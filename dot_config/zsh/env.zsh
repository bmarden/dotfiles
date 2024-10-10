# GO setup
if [ -n "$(command -v go)" ]; then
  export GOPATH=$(go env GOPATH)
  export GOROOT=$(go env GOROOT)
  path+=($GOPATH/bin $GOROOT/bin)
fi
