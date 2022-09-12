call plug#begin('~/.config/nvim/plugins')
  Plug 'tpope/vim-commentary'
	Plug 'junegunn/vim-easy-align'
	Plug 'machakann/vim-highlightedyank'
	Plug 'tpope/vim-repeat'
	" Surround 
	Plug 'tpope/vim-surround'

	if exists('g:vscode')
		Plug 'asvetliakov/vim-easymotion'
	else
		" Themes
		Plug 'joshdick/onedark.vim'
		Plug 'ayu-theme/ayu-vim'
		Plug 'sainnhe/sonokai'
		" Plug 'owozsh/amora'

		" Status line
		Plug 'itchyny/lightline.vim'
		Plug 'justinmk/vim-sneak'
	  Plug 'justinmk/vim-syntax-extra'
		" Fancy start screen for vim
		Plug 'mhinz/vim-startify'
		" 
		Plug 'alvan/vim-closetag'
		" Auto pairs for ( [ {
		Plug 'jiangmiao/auto-pairs'
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
		" Syntax highlighting for zinit files
		Plug 'zdharma-continuum/zinit-vim-syntax'
endif

call plug#end()

