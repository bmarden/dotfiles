#!/bin/bash

# Ensure homebrew is initialized
[ -n "$(command -v /opt/homebrew/bin/brew)" ] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

## Setup and install asdf plugins ##
# nodejs

plugins=("golang" "nodejs" "python" "dotnet" "ruby")  # List of plugins to check and install

# Iterate over each plugin
for plugin in "${plugins[@]}"; do
  if [[ $(asdf plugin-list) != *"$plugin"* ]]; then
    echo "Installing $plugin..."
    asdf plugin-add "$plugin"
  else
    echo "$plugin is already installed."
  fi
done
