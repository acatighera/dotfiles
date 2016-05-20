set nocp
set rtp+=~/.vim/autoload/pathogen.vim
call pathogen#infect()
syntax on
filetype plugin indent on

set guifont=Menlo\ Regular:h14
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
:set number
:colorscheme ir_black

let NERDTreeQuitOnOpen=1
let mapleader = ","
nmap <leader>n :NERDTreeFocus<cr>

set runtimepath^=~/.vim/bundle/ctrlp.vim

set clipboard=unnamed

