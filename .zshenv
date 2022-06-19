#!/bin/zsh

# $HOME/.local/bin in path
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# Default
export EDITOR="nvim"
export BIB="$HOME/Documents/University/uni.bib"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Clean
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/.gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export YTFZF_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ytfzf"

# NVIDIA VA-API
export LIBVA_DRIVER_NAME="nvidia" # This forces libva to load the nvidia backend, as the current version doesn't know which driver to load for the nvidia-drm driver.
# export LIBVA_DRIVER_NAME="vdpau"
# export VDPAU_DRIVER="nvidia"
export MOZ_DISABLE_RDD_SANDBOX="0"
#export MOZ_DISABLE_RDD_SANDBOX="1" # This disables the sandbox for the RDD process that the decoder runs in.
#export EGL_PLATFORM="wayland" # This option is needed on FF98+ when running on Wayland, due to a regression that has been introduced.

# Etc Progs
export DICS="/usr/share/stardict/dic/"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
#export _JAVA_AWT_WM_NONREPARENTING=1
#export STEAM_FRAME_FORCE_CLOSE=1 #force steam to tray
#export QT_QPA_PLATFORMTHEME="qt5ct"

# Slow Gnome Apps Fix
#dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

#fcitx
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export GLFW_IM_MODULE=ibus

# A E S T H E T I C
export PF_INFO="ascii title os kernel uptime wm pkgs memory palette"

[ -f "$HOME/.config/.aliasrc" ] && source "$HOME/.config/.aliasrc"

#xset mouse 7/8 0

# if [[ "$(tty)" == '/dev/tty1' ]]; then
# 	exec startx
# fi
