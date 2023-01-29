# GO setup
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
# export GOBIN=$(go env GOBIN)

path+=($GOPATH/bin $GOROOT/bin)
# path+=($GOBIN)
