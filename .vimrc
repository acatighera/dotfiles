call plug#begin()

Plug 'kien/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-bundler'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-vinegar'
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'
Plug 'christoomey/vim-tmux-navigator'
Plug 'isruslan/vim-es6'
Plug 'chrisbra/csv.vim'
Plug 'rking/ag.vim'
Plug 'valloric/youcompleteme'
Plug 'rust-lang/rust.vim'
Plug 'rust-analyzer/rust-analyzer'


filetype plugin indent on
syntax on

set linespace=1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set laststatus=2
set encoding=utf-8
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/public/*
set completeopt-=preview
set nocompatible
set ttyfast
set lazyredraw
set splitbelow

:set number
"set colorcolumn=80
if &term == "screen"
  set t_Co=256
endif
:colorscheme bubblegum-256-dark
highlight ColorColumn ctermbg=240 guibg=#000000

set clipboard=unnamedplus
set nocursorline

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:airline#extensions#whitespace#trailing_format = 'trl[%s]'
"let g:airline_powerline_fonts=1
let g:go_bin_path=$HOME."/go/bin"

" searching
" Use ag over grep
set grepprg=/usr/bin/ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = '/usr/bin/ag %s -l --nocolor --ignore .git --ignore .DS_Store -g ""'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 150
let g:ctrlp_max_files = 0

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

let g:deoplete#enable_at_startup = 1

let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_disable_for_files_larger_than_kb = 1000

let $BASH_ENV = "~/.bash_aliases"

call plug#end()
