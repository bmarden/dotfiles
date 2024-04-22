#!/bin/bash

# Install homebrew if it's not already installed
type brew >/dev/null 2>&1 && exit

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Set up homebrew in the current shell
eval "$(/opt/homebrew/bin/brew shellenv)"

# Update homebrew
brew update