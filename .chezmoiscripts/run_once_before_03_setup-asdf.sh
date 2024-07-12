#!/usr/bin/env bash

# Ensure homebrew is initialized
[ -n "$(command -v /opt/homebrew/bin/brew)" ] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

# Ensure asdf is initialized
if [ ! "$(command -v asdf)" ]; then
  echo "asdf not installed. Skipping asdf setup."
  exit 0
fi

# shellcheck source=/dev/null
source "$(brew --prefix asdf)/libexec/asdf.sh"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
# Temporarily point to the location in chezmoi source since it may not be available in $XDG_CONFIG_HOME yet
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_DATA_HOME/chezmoi/dot_config/asdf/default-npm-packages"
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/config"
export npm_config_cache="$XDG_CACHE_HOME/npm"
export npm_config_prefix="$XDG_DATA_HOME/npm"

## Setup and install asdf plugins ##
declare -A plugins
plugins[nodejs]="20.12.2"
plugins[java]="zulu-17.46.19"
plugins[ruby]="3.2.2"
plugins[python]="3.12.1"
plugins[cocoapods]="1.15.2"
plugins[golang]="1.22.2"
plugins[dotnet]="8.0.302"
plugins[direnv]="latest"

install_order=(
  "nodejs"
  "java"
  "ruby"
  "python"
  "golang"
  "dotnet"
  "direnv"
)

# Function to install a plugin
install_plugin() {
  local plugin=$1
  local version=${plugins[$plugin]}

  echo "Adding $plugin..."
  asdf plugin-add "$plugin"
  echo "Installing AH version for plugin $plugin..."
  asdf install "$plugin" "$version"
  echo "Setting global version for $plugin..."
  asdf global "$plugin" "$version"
}

# Install plugins in the specified order
for plugin in "${install_order[@]}"; do
  install_plugin "$plugin"
done

# List current asdf configuration
asdf current

# Reload asdf so that the asdf version of ruby is used when installing cocoapods
# shellcheck source=/dev/null
. "$(brew --prefix asdf)/libexec/asdf.sh"
install_plugin "cocoapods"