#
# 03-post-antidote - Undo any settings from plugins you don't like.
#

# options
unsetopt BEEP
unsetopt HISTBEEP

# Choose your preferred keybindings.
bindkey -v  # Vi keybindings

# Set your prompt
autoload -Uz promptinit && promptinit
prompt powerlevel10k


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
