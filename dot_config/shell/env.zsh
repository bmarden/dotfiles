# setup editor
export EDITOR=nvim

# GO setup
if [ -n "$(command -v go)" ]; then
  export GOPATH=$(go env GOPATH)
  export GOROOT=$(go env GOROOT)
  path+=($GOPATH/bin $GOROOT/bin)
fi

if [ -n "$(command -v java)" ] && [ -f "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh" ]; then
  . "$ASDF_DATA_DIR/plugins/java/set-java-home.zsh"
fi

# pnpm setup
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# bun setup
export BUN_INSTALL="$HOME/.bun"

# vi mode settings
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_VI_ESCAPE_BINDKEY=jk
export ZVM_VI_EDITOR=nvim

# # Set up fzf env vars
export FZF_DEFAULT_COMMAND='fd --type file --color=never --follow --hidden --exclude .git'
export FZF_DEFAULT_OPS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# android studio
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_USER_HOME="$XDG_CONFIG_HOME/android"

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# set npm paths
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/config"
export npm_config_cache="$XDG_CACHE_HOME/npm"
export npm_config_prefix="$XDG_DATA_HOME/npm"

# set expo config
export EAS_LOCAL_BUILD_ARTIFACTS_DIR="${CODE_HOME-$HOME/code}/builds"

# set direnv to not output logs
export DIRENV_LOG_FORMAT=""

# Add vars to path
path+=($ANDROID_HOME/emulator $ANDROID_HOME/tools \ 
  $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools
  $ANDROID_HOME/cmdline-tools/latest/bin "/Applications/Android Studio.app/Contents/jre/Contents/Home/bin"
  "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
  "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" $HOME/.dotnet/tools $PNPM_HOME
  "$BUN_INSTALL/bin")

typeset -aU path
