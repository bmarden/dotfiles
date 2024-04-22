#!/usr/bin/env bash

# Ensure homebrew is initialized
[ -n "$(command -v /opt/homebrew/bin/brew)" ] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

# Ensure asdf is initialized
if [ -n "$(command -v asdf)" ]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
  export ASDF_DATA_DIR="$HOME/.local/share/asdf"
  # Temporarily point to the location in chezmoi source since it may not be available in $XDG_CONFIG_HOME yet
  export ASDF_NPM_DEFAULT_PACKAGES_FILE="$HOME/.local/share/chezmoi/dot_config/asdf/default-npm-packages"
else
  echo "asdf not installed. Skipping asdf setup."
  exit 0
fi

## Setup and install asdf plugins ##
declare -A plugins
plugins[nodejs]="20.12.2"
plugins[java]="zulu-17.46.19"
plugins[ruby]="3.2.2"
plugins[python]="3.12.1"
plugins[cocoapods]="1.15.2"
plugins[golang]="1.22.2"

# Add each plugin, install AH version and set global
for plugin in "${!plugins[@]}"; do
  echo "Adding $plugin..."
  asdf plugin-add "$plugin"

  ah_plugin_version="${plugins[$plugin]}"

  echo "Installing AH version for plugin $plugin..."
  asdf install "$plugin" "$ah_plugin_version"

  echo "Setting global version for $plugin..."
  asdf global "$plugin" "$ah_plugin_version"
done
