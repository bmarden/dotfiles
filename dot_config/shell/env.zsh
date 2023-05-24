# GO setup
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)

# pnpm setup
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# # Set up fzf env vars
export FZF_DEFAULT_COMMAND='fd --type file --color=never --follow --hidden --exclude .git'
export FZF_DEFAULT_OPS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# Add vars to path
path=($PNPM_HOME $path)
path+=($GOPATH/bin $GOROOT/bin $(brew --prefix)/opt/postgresql@15/bin)
