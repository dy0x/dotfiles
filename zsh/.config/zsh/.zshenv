#!/bin/zsh

export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):$HOME/.local/share/cargo/bin"

# Default
export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
#export XDG_RUNTIME_DIR="$TMPDIR/runtime-$UID"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Clean
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/.gnupg"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NRFUTIL_HOME="$XDG_DATA_HOME"/nrfuti
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"

# MacOS
export SHELL_SESSIONS_DISABLE=1

# Etc Progs
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

[ -f "$HOME/.config/.aliasrc" ] && source "$HOME/.config/.aliasrc"
#. "/home/dylan/.local/share/cargo/env"
