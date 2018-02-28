syntax on
set t_Co=8
set background=dark
set nocompatible
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set tabstop=4
set mouse=a
set nolist
set ignorecase
set smartcase
set title
set clipboard=unnamed
set wildmenu
set modeline
set hlsearch
set ruler
set showmode
set showcmd
set autoindent

set number
set numberwidth=3
hi LineNr cterm=None ctermfg=Black

set cursorline
hi CursorLine cterm=None ctermbg=Black ctermfg=None
hi CursorLineNr ctermbg=Black ctermfg=Cyan

set laststatus=2

let mapleader = " "
let g:mapleader = " "

nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
