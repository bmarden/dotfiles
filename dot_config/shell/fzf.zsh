# Setup fzf - cross-platform
# ---------
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS with Homebrew
  FZF_BASE="/opt/homebrew/opt/fzf"
  if [[ ! "$PATH" == *${FZF_BASE}/bin* ]]; then
    PATH="${PATH:+${PATH}:}${FZF_BASE}/bin"
  fi
  FZF_COMPLETION="${FZF_BASE}/shell/completion.zsh"
  FZF_KEY_BINDINGS="${FZF_BASE}/shell/key-bindings.zsh"
else
  # Linux - fzf installed to ~/.fzf
  FZF_BASE="$HOME/.fzf"
  if [[ ! "$PATH" == *${FZF_BASE}/bin* ]]; then
    PATH="${PATH:+${PATH}:}${FZF_BASE}/bin"
  fi
  FZF_COMPLETION="${FZF_BASE}/shell/completion.zsh"
  FZF_KEY_BINDINGS="${FZF_BASE}/shell/key-bindings.zsh"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && [[ -f "$FZF_COMPLETION" ]] && source "$FZF_COMPLETION" 2>/dev/null

# Key bindings (modified)
# ------------
# Use the zvm_after_init_commands array to add commands to be run after vi-mode is initialized. This
# makes sure that zsh-vi-mode doesn't overwrite Ctrl-R keybinding for fzf.
if [[ -f "$FZF_KEY_BINDINGS" ]]; then
  zvm_after_init_commands+=("source $FZF_KEY_BINDINGS")
fi

fzf_change_directory() {
  local directory=$(
    fd --type d |
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
    pid_col=3
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
