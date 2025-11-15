#!/bin/zsh
# vim syntax=sh

# Initialize bashcompinit if not already initialized
# bashcompinit is pre-loaded in .zshrc before zimfw initialization
# to avoid duplicate compinit calls
if ! type complete >/dev/null 2>&1; then
  bashcompinit
fi

# Add terraform completion
if command -v terraform &> /dev/null; then
  complete -o nospace -C "$(command -v terraform)" terraform
fi

# Add az completion
if [[ "$OSTYPE" == "darwin"* ]] && [[ -f /opt/homebrew/etc/bash_completion.d/az ]]; then
  complete -o nospace -C /opt/homebrew/etc/bash_completion.d/az
elif command -v az &> /dev/null; then
  # On Linux, az-cli provides its own completion
  if [[ -f /etc/bash_completion.d/azure-cli ]]; then
    source /etc/bash_completion.d/azure-cli
  fi
fi
