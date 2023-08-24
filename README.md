# dotfiles

My personal dotfiles repo. Uses chezmoi

## Installing

### Install homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install chezmoi

```bash
brew install chezmoi
```

### Use chezmoi to install dotfiles

```bash
chezmoi init --apply $GITHUB_USERNAME
```

Or

```bash
chezmoi init --apply https://github.com/bmarden/dotfiles.git
```
