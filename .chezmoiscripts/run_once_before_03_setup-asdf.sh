#!/bin/bash

# Ensure homebrew is initialized
[ -n "$(command -v /opt/homebrew/bin/brew)" ] &&
  eval "$(/opt/homebrew/bin/brew shellenv)"

## Setup and install asdf plugins ##
# nodejs
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs lts
asdf global nodejs lts

# golang
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang latest
asdf global golang latest
