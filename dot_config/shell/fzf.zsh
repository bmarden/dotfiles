# Following was generated from /opt/homebrew/opt/fzf/install 
# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
# End of generation from /opt/homebrew/opt/fzf/install

fzf_change_directory() {
    local directory=$(
      fd --type d | \
      fzf --query="$1" --no-multi --select-1 --exit-0 \
          --preview 'tree -C {} | head -100'
      )
    if [[ -n $directory ]]; then
        cd "$directory"
    fi
}
alias fcd='fzf_change_directory'

fzf_kill() {
    local pid_col
    if [[ $(uname) = Linux ]]; then
        pid_col=2
    elif [[ $(uname) = Darwin ]]; then
        pid_col=3;
    else
        echo 'Error: unknown platform'
        return
    fi
    local pids=$(
      ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f"$pid_col"
      )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}
alias fkill='fzf_kill'
