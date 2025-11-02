#!/usr/bin/env bash

# Ensure mise is installed and initialized
if [ ! "$(command -v mise)" ]; then
  echo "mise not installed. Skipping mise setup."
  exit 0
fi

# Initialize mise
eval "$(mise activate bash)"
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/config"
export npm_config_cache="$XDG_CACHE_HOME/npm"
export npm_config_prefix="$XDG_DATA_HOME/npm"

## Setup and install mise/asdf plugins ##
declare -A plugins
plugins[nodejs]="latest"
# plugins[java]="zulu-17.46.19"
# plugins[ruby]="3.2.2"
plugins[python]="3.12.1"
plugins[golang]="1.25.3"

# On macOS, also install cocoapods
if [[ "$OSTYPE" == "darwin"* ]]; then
  plugins[cocoapods]="1.15.2"
fi

install_order=(
  "nodejs"
  # "java"
  # "ruby"
  "python"
  "golang"
)

# Function to install a plugin with mise
install_plugin() {
  local plugin=$1
  local version=${plugins[$plugin]}

  echo "Installing $plugin@$version with mise..."
  mise use -g "$plugin@$version"
}

# Install plugins in the specified order
for plugin in "${install_order[@]}"; do
  install_plugin "$plugin"
done

# Install cocoapods after ruby on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Reload mise so that the mise version of ruby is used when installing cocoapods
  eval "$(mise activate bash)"
  install_plugin "cocoapods"
fi

# List current mise configuration
mise list

