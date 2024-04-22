# dotfiles

My personal dotfiles repo. Uses chezmoi

## Installing

### One liner

```bash
/bin/bash -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bmarden
```

### Or install manually

#### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install chezmoi

```bash
brew install chezmoi
```

### Use chezmoi to install dotfiles

```bash
chezmoi init --apply bmarden
```
