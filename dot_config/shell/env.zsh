# GO setup
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)

# pnpm setup
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# Add vars to path
path=($PNPM_HOME $path)
path+=($GOPATH/bin $GOROOT/bin $(brew --prefix)/opt/postgresql@15/bin)
