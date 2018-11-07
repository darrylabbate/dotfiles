execute pathogen#infect()
filetype indent plugin on

set noswapfile

set path+=**
set wildmenu

set t_Co=256
syntax on

set tabstop=2
set shiftwidth=2
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
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'modified' ] ],
      \   'right': [ [ 'filetype' ],
      \              [ 'gitbranch', 'readonly', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:limelight_conceal_ctermfg = 'gray'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Use C++ style comments in C files
autocmd FileType c setlocal commentstring=//\ %s

" Haskell
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2

" Indent using 4 spaces in Java
" I can't wait to delete this
autocmd FileType java setlocal shiftwidth=4
autocmd FileType java setlocal tabstop=4

" gitgutter
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'
let g:gitgutter_sign_modified_removed = '•'
