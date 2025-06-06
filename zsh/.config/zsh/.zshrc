
IS_MAC=false
IS_LINUX=false

case "$(uname -s)" in
  Darwin) IS_MAC=true ;;
  Linux)  IS_LINUX=true ;;
esac

if $IS_MAC; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  export PNPM_HOME="/Users/dylanoxenbridge/Library/pnpm"
  case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
elif $IS_LINUX; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
stty stop undef # Disable freezing term with ctrl+s
setopt autocd # Auto cd into typed dir
setopt interactive_comments

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000


mkdir -p "$XDG_CACHE_HOME"/zsh

autoload -Uz compinit
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # auto capitalize
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
compinit
_comp_options+=(globdots) #include dotfiles
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Automatically quote pasted urls
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Vi mode
bindkey -v
export KEYTIMEOUT=1

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

# Use ranger to switch directories and bind it to ctrl-o
# rangercd () {
#     tmp="$(mktemp)"
#     ranger --choosedir="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp" >/dev/null
#     	[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# bindkey -s '^o' 'rangercd\n'
bindkey -s '^o' 'lfcd\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# fix systemctl auto complete in zsh.
# _systemctl_unit_state() {
#   typeset -gA _sys_unit_state
#   _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') ) }

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

[ -f "$HOME/.config/.aliasrc" ] && source "$HOME/.config/.aliasrc"
eval "$(starship init zsh)"
