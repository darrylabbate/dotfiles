call plug#begin('~/.vim/plugs')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'nbouscal/vim-stylish-haskell', {'for': 'haskell'}
Plug 'niklaas/lightline-gitdiff'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()

filetype indent plugin on

set noswapfile

set path+=**
set wildmenu

set t_Co=16
set bg=dark
syntax on

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set mouse=a
set nolist
set ignorecase
set smartcase
set hlsearch
set showcmd
set incsearch
set showmatch
set noshowmode
set modelines=0
set nomodeline

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set number
set relativenumber
set numberwidth=2
hi LineNr cterm=None ctermfg=DarkGray

set cursorline
hi CursorLine cterm=None ctermbg=Black ctermfg=None
hi CursorLineNr ctermbg=Black ctermfg=Cyan

set laststatus=2
hi statusline  cterm=None ctermfg=Cyan

noremap <space> :

let mapleader = " "
let g:mapleader = " "

nmap <leader>b :b<space>
nmap <leader>e :edit<space>
nmap <leader>f :find<space>
nmap <leader>q :q<cr>
nmap <leader>s :%s/
nmap <leader>v :vs<cr>
nmap <leader>w :w!<cr>

inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>

nmap ga <Plug>(EasyAlign)

let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ 'active': {
  \   'left':  [ [ 'mode', 'paste' ],
  \              [ 'filename', 'modified' ],
  \              [ 'gitdiff' ] ],
  \   'right': [ [ 'filetype' ],
  \              [ 'gitbranch', 'readonly' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ 'component_expand': {
  \   'gitdiff': 'lightline#gitdiff#get',
  \ },
  \ 'component_type': {
  \   'gitdiff': 'middle',
  \ },
  \ }

let g:lightline.mode_map = {
  \ 'n' : 'N',
  \ 'i' : 'I',
  \ 'R' : 'R',
  \ 'v' : 'V',
  \ 'V' : 'V-LINE',
  \ "\<C-v>": 'V-BLOCK',
  \ 'c' : 'C',
  \ 's' : 'S',
  \ 'S' : 'S-LINE',
  \ "\<C-s>": 'S-BLOCK',
  \ 't': 'T',
  \ }

let g:lightline#gitdiff#indicator_added    = '+'
let g:lightline#gitdiff#indicator_deleted  = '-'
let g:lightline#gitdiff#indicator_modified = 'Δ'
let g:lightline#gitdiff#separator          = ' '

" Spellcheck markdown files
autocmd FileType markdown setlocal spell spelllang=en_us

" Use C++ style comments in C files
autocmd FileType c setlocal commentstring=//\ %s

" Haskell
let g:haskell_indent_if               = 3
let g:haskell_indent_case             = 2
let g:haskell_indent_let              = 4
let g:haskell_indent_where            = 6
let g:haskell_indent_before_where     = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do               = 3
let g:haskell_indent_in               = 1
let g:haskell_indent_guard            = 2

" Assembly
autocmd FileType asm setlocal shiftwidth=8
autocmd FileType asm setlocal tabstop=8
