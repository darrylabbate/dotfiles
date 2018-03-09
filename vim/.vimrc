set noswapfile
set backupdir=~/.vim/backups

set path+=**
set wildmenu

syntax on
set t_Co=8
set nocompatible
set tabstop=4
set mouse=a
set nolist
set ignorecase
set smartcase
set hlsearch
set showcmd
set autoindent
set incsearch

set number
set relativenumber
set numberwidth=3
hi LineNr cterm=None ctermfg=Black

set cursorline
hi CursorLine cterm=None ctermbg=Black ctermfg=None
hi CursorLineNr ctermbg=Black ctermfg=Cyan

set laststatus=2
hi statusline  cterm=None ctermfg=Cyan

let mapleader = " "
let g:mapleader = " "

nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
