source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/key_bindings.vim
source $HOME/.config/nvim/plug-config/highlight-yank.vim

" Theme
source $HOME/.config/nvim/themes/sonokai.vim

" Plugin configurations
source $HOME/.config/nvim/plug-config/sneak.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/quickscope.vim
source $HOME/.config/nvim/plug-config/closetags.vim

# automatically run apply when editing chezmoi files 
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
