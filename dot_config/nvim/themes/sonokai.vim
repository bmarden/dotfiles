let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
    set termguicolors
endif
set background=dark

let g:sonokai_style = 'shusia'
syntax on
colorscheme sonokai
let g:lightline = {'colorscheme' : 'sonokai'}
