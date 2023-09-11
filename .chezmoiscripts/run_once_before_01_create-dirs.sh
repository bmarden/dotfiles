#!/bin/bash

REQUIRED_DIRS=(
  "$HOME/bin"
  "$HOME/.zsh/completions"
  "$HOME/.zsh/functions"
  "$HOME/.ssh"
  "$HOME/code"
)

for DIR in "${REQUIRED_DIRS[@]}"; do
  if [ ! -d "${DIR}" ]; then
    mkdir -p "${DIR}"
  fi
done
