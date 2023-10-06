#!/bin/bash

# Ensure homebrew is initialized
[ -n "$(command -v /opt/homebrew/bin/brew)" ] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

# Ensure asdf is initialized
if [ -n "$(command -v asdf)" ]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
  export ASDF_DATA_DIR="$HOME/.local/share/asdf"
  export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ASDF_DATA_DIR/.default-npm-packages"
else
  echo "asdf not installed. Skipping asdf setup."
  exit 0
fi

## Setup and install asdf plugins ##
plugins=("golang" "nodejs" "python" "ruby" "dotnet")  # List of plugins to check and install

# Iterate over each plugin
for plugin in "${plugins[@]}"; do
  echo "Adding $plugin..."
  asdf plugin-add "$plugin"

  # Construct the env variable name
  plugin_upper=$(echo "$plugin" | tr '[:lower:]' '[:upper:]')
  asdf_plugin_version="ASDF_${plugin_upper}_VERSION"
  
  if [ -z "${!asdf_plugin_version}" ]; then

    echo "No version set for plugin $plugin. Skipping..."
    continue
  fi

  echo "Installing AH version for plugin $plugin..."
  asdf install "$plugin" "${!asdf_plugin_version}"

  echo "Setting global version for $plugin..."
  asdf global "$plugin" "${!asdf_plugin_version}"
done
