#!/bin/bash

# Ensure homebrew is initialized
[ -n "$(command -v /opt/homebrew/bin/brew)" ] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

# Ensure asdf is initialized
if [ -n "$(command -v asdf)" ]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
  # export ASDF_DATA_DIR="$HOME/.local/share/asdf"
  # export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ASDF_DATA_DIR/.default-npm-packages"
else
  echo "asdf not installed. Skipping asdf setup."
  exit 0
fi

## Setup and install asdf plugins ##
plugins=("nodejs" "ruby" "dotnet" "java")  # List of plugins to check and install

# Iterate over each plugin
for plugin in "${plugins[@]}"; do
  if [[ $(asdf plugin-list) != *"$plugin"* ]]; then
    echo "Installing $plugin..."
    asdf plugin-add "$plugin"
  else
    echo "$plugin is already installed."
  fi
done
