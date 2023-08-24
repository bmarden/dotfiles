# dotfiles

My personal dotfiles repo. Uses chezmoi

## Installing

1. Install homebrew  

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install chezmoi
```bash
brew install chezmoi
```

3. Use chezmoi to install dotfiles
```bash
chezmoi init --apply $GITHUB_USERNAME
# or 
chezmoi init --apply https://github.com/bmarden/dotfiles.git
```
