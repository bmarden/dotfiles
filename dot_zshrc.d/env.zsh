# VIVID LS_COLORS
[ -n "$(command -v vivid)" ]                                       \
    && export LS_COLORS="$(vivid generate molokai)"

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_VI_ESCAPE_BINDKEY=jk
