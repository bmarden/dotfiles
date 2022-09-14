#!/bin/bash

XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_STATE_HOME="$HOME/.local/state"

REQUIRED_DIRS=(
  "$XDG_CONFIG_HOME/zsh"
  "$XDG_STATE_HOME/zsh"
  "$XDG_DATA_HOME/zinit"
  "$XDG_DATA_HOME/asdf"
  "$XDG_DATA_HOME/android"
  "$XDG_CACHE_HOME/npm"
  "$XDG_CONFIG_HOME/npm"
  "$XDG_DATA_HOME/npm"
)

for DIR in "${REQUIRED_DIRS[@]}"; do
  if [ ! -d "${DIR}" ]; then
    mkdir -p "${DIR}"
  fi
done
