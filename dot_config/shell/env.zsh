# setup editor
export EDITOR="nvim"

# GO setup
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)

# pnpm setup
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# vi mode settings
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_VI_ESCAPE_BINDKEY=jk

# # Set up fzf env vars
export FZF_DEFAULT_COMMAND='fd --type file --color=never --follow --hidden --exclude .git'
export FZF_DEFAULT_OPS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# android studio
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME/android"
export ANDROID_AVD_HOME="$XDG_DATA_HOME/android/avd"

export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home/"

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# set npm paths
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/config"
export npm_config_cache="$XDG_CACHE_HOME/npm"
export npm_config_prefix="$XDG_DATA_HOME/npm"

# set gem paths
export GEM_HOME="${XDG_DATA_HOME}"/gem
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem

# set cocoapods path, stores cache and repos here
export CP_HOME_DIR="$XDG_DATA_HOME/cocoapods"

# set expo config
export EAS_LOCAL_BUILD_ARTIFACTS_DIR="$HOME/builds"

# Add vars to path
path=($PNPM_HOME $path)
path+=($GOPATH/bin $GOROOT/bin)
