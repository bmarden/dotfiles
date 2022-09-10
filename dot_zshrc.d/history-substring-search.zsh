#
# history-substring-search
#

# https://github.com/zsh-users/zsh-history-substring-search
if [[ -n "$key_info" ]]; then
  # Vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # Vi
  for keymap in 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done

  unset keymap
fi

