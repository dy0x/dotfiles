# ~/zprofile

# $HOME/.local/bin in path
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# Default Progs
export FILE="ranger"
export TERMINAL="st"
export EDITOR="nvim"
export BROWSER="firefox"
export READER="zathura"

# Clean
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export LESSHISTFILE="/dev/null/"
export ZDOTDIR="$HOME/.config/zsh"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# Etc Progs
export DICS="/usr/share/stardict/dic/"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export _JAVA_AWT_WM_NONREPARENTING="1"

# Enable Hangul with Nabi
export XIM=nabi
export XIM_ARGS=
export XIM_PROGRAM="nabi"
export XMODIFIERS="@im=nabi"
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# Slow Gnome Apps Fix
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# A E S T H E T I C
export PF_INFO="ascii title os kernel pkgs memory wm shell palette"

[ -f "$HOME/.config/.aliasrc" ] && source "$HOME/.config/.aliasrc"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
