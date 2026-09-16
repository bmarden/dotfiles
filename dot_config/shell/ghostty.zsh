# Ghostty has no scrollback_pager equivalent. `write_scrollback_file:paste`
# drops the temp file path onto the command line; ctrl-x ctrl-s then opens
# that path in nvim, replacing what kitty-scrollback.nvim did under kitty.
_ghostty_scrollback() {
  local f=${${BUFFER##* }%%[[:space:]]##}
  [[ -r $f ]] || return 1
  BUFFER=
  zle reset-prompt
  nvim -c 'setlocal nomodified readonly nolist' -c 'silent! TermHl' -c 'normal! G' -- "$f"
  command rm -f -- "$f"
  zle reset-prompt
}
zle -N _ghostty_scrollback
bindkey '^X^S' _ghostty_scrollback
