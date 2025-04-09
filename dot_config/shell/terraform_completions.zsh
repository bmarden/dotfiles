#!/bin/zsh
# vim syntax=sh

# Load bashcompinit if not already loaded
if ! type bashcompinit >/dev/null 2>&1; then
  autoload -U +X bashcompinit
  bashcompinit
fi

# Add terraform completion
complete -o nospace -C /opt/homebrew/bin/terraform terraform