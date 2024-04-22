#!/usr/bin/env bash

# check for the following files and back them up if they exist
# ~/.zshrc
# ~/.zshenv
# ~/.zprofile

files=(~/.zshrc ~/.zshenv ~/.zprofile)
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    echo "Backing up $file to $file.bak and removing the original file"
    cp "$file" "$file.bak"
    rm "$file"
  fi
done

# Install homebrew if it's not already installed
type brew >/dev/null 2>&1 && exit

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Set up homebrew in the current shell
eval "$(/opt/homebrew/bin/brew shellenv)"