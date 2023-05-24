# dotfiles

My personal dotfiles repo. Uses chezmoi

## Installing

1. Install homebrew  
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

2. Use chezmoi binary to clone dotfiles and setup  
`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME`
