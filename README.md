# dotfiles

My personal dotfiles repo. Uses chezmoi

## Installing

1. Install homebrew  
   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

2. Install chezmoi  
   `brew install chezmoi`

3. Use chezmoi to install dotfiles
   `chezmoi init --apply $GITHUB_USERNAME`
