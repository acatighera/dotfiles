call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-bundler'

syntax on
filetype plugin indent on

set guifont=Monospace\ 10
set linespace=1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
:set number
:colorscheme ir_black

let NERDTreeQuitOnOpen=1
let mapleader = ","
nmap <leader>n :NERDTreeFocus<cr>


set clipboard=unnamed

call plug#end()
