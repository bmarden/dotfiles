DISABLE_AUTO_TITLE="true"
tab_title() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}
add-zsh-hook precmd tab_title
