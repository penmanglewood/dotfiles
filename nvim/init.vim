call plug#begin('~/.config/nvim/data/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
Plug 'elzr/vim-json'
Plug 'tpope/vim-commentary'
Plug 'hashivim/vim-terraform'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/fzf'

call plug#end()

let mapleader = " "

set backspace=2
set nocompatible
set number
set ruler
set numberwidth=5
set showcmd
set incsearch
set laststatus=2 " Always display the status line
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set noshowmode
set tabstop=2
set shiftwidth=2
set expandtab

nnoremap <leader><leader> <c-^>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <leader>n :NERDTreeToggle<CR>

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

set history=1000

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:vim_json_syntax_conceal=0

autocmd FileType tf setlocal commentstring=#\ %s

" Required for operations modifying multiple buffers like rename
set hidden
let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls'],
  \ }

" disable vim-go :GoDef shortcut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled=0
