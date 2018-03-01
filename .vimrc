syntax on
set t_Co=8
set nocompatible
set backupdir=~/.vim/backups
set tabstop=4
set mouse=a
set nolist
set ignorecase
set smartcase
set title
set modeline
set hlsearch
set showmode
set showcmd
set autoindent
set incsearch

set number
set numberwidth=3
hi LineNr cterm=None ctermfg=Black

set cursorline
hi CursorLine cterm=None ctermbg=Black ctermfg=None
hi CursorLineNr ctermbg=Black ctermfg=Cyan

set laststatus=2
hi StatusColor2 cterm=None ctermfg=Cyan
set statusline=
set statusline+=%#StatusColor2#
set statusline+=%=
set statusline+=%F

let mapleader = " "
let g:mapleader = " "

nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
