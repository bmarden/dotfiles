# eza reads its theme.yml from EZA_CONFIG_DIR; on macOS it otherwise
# defaults to ~/Library/Application Support/eza instead of ~/.config/eza
export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"

# GO setup
if [ -n "$(command -v go)" ]; then
  export GOPATH=$(go env GOPATH)
  export GOROOT=$(go env GOROOT)
  path+=($GOPATH/bin $GOROOT/bin)
fi
