# Platform and optional plugins
IS_MAC=false
IS_LINUX=false

case "$(uname -s)" in
  Darwin) IS_MAC=true ;;
  Linux)  IS_LINUX=true ;;
esac

if $IS_MAC; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  if (( $+commands[brew] )); then
    autosuggestions="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    if [[ -r "$autosuggestions" ]]; then
      source "$autosuggestions"
    fi
    unset autosuggestions
  fi

  codex() {
    local theme=gruvbox-light
    if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == Dark ]]; then
      theme=gruvbox-dark
    fi
    command codex -c "tui.theme=$theme" "$@"
  }
elif $IS_LINUX; then
  if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi
  # (cat ~/.cache/wal/sequences &)
fi

# Prompt and shell behaviour
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
[[ -t 0 ]] && stty stop undef # Disable terminal flow control with Ctrl-S
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt nobeep
setopt numeric_glob_sort
setopt interactive_comments

# History
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_verify
setopt hist_ignore_space
setopt hist_find_no_dups

# Completion
mkdir -p "$XDG_CACHE_HOME"/zsh

setopt complete_in_word
autoload -Uz compinit
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Lowercase matches either case
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
_comp_options+=(globdots) # Include dotfiles
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Automatically quote pasted urls
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Vi mode and keybindings
bindkey -v
export KEYTIMEOUT=1

# Search history by the text typed before the cursor.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# File and remote navigation
yazicd() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

hermes() {
    local remote_command="/home/hermes/.local/bin/hermes"
    local tmux_window old_window_name old_auto_rename exit_code
    if [[ -n "$TMUX" && -n "$TMUX_PANE" ]]; then
        tmux_window=$(tmux display-message -p -t "$TMUX_PANE" '#{window_id}')
        old_window_name=$(tmux display-message -p -t "$tmux_window" '#{window_name}')
        old_auto_rename=$(tmux show-window-options -v -t "$tmux_window" automatic-rename 2>/dev/null)
        tmux rename-window -t "$tmux_window" hermes
    fi
    if $IS_MAC; then
        local skin=warm-lightmode
        if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == Dark ]]; then
            skin=default
        fi
        remote_command+=" skin use $skin && /home/hermes/.local/bin/hermes"
    fi
    ssh -t hermes@192.168.0.21 "$remote_command $*"
    exit_code=$?
    if [[ -n "$tmux_window" ]]; then
        tmux rename-window -t "$tmux_window" "$old_window_name"
        if [[ -n "$old_auto_rename" ]]; then
            tmux set-window-option -t "$tmux_window" automatic-rename "$old_auto_rename"
        else
            tmux set-window-option -u -t "$tmux_window" automatic-rename
        fi
    fi
    return $exit_code
}

# Search command history with fzf in vi insert mode.
if (( $+commands[fzf] )); then
    fzf-history-search() {
        local selected
        selected=$(fc -rl 1 | fzf --scheme=history --query="$LBUFFER") || return
        zle vi-fetch-history -n "${${(z)selected}[1]}"
        zle reset-prompt
    }
    zle -N fzf-history-search
    bindkey -M viins '^t' fzf-history-search
fi

# Open the tmux session picker without replacing the current command line.
tmux-session-picker() {
    zle -I
    tmux-sessionizer
    zle reset-prompt
}
zle -N tmux-session-picker
bindkey -M viins '\es' tmux-session-picker
bindkey -M vicmd '\es' tmux-session-picker

bindkey -s '^o' 'yazicd\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Tool paths and integrations
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

[ -f "$HOME/.config/.aliasrc" ] && source "$HOME/.config/.aliasrc"
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
