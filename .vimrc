" Syntax highlight
syntax on

" Enable filetype detection, plugins, and indentation
filetype plugin indent on

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

" Save before :make, :suspend, etc
set autowrite

" Show partial command in status line
set showcmd

" Show matching brackets
set showmatch

" We use bash
set shell=bash

" Suffixes that get lower priority when doing tab completion for filenames
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Show matches while searching
set incsearch

" Highlight searches
set hlsearch

" Case-insensitive search
set ignorecase

" Case-sensitive if uppercase present
set smartcase

" Enable UTF-8
set encoding=utf-8
set fileencodings=utf-8,iso-8859-1

" Linewidth to endless
set textwidth=0

set autoindent
set smartindent

" Tab-behavior
" tab-characters will display as 2 spaces
set tabstop=2
" pressing tab / indenting will produce 2 spaces
set shiftwidth=2
" backspace will clear 2 spaces, equal to a tab
set softtabstop=2
" use spaces instead of tab characters
set expandtab

" Show line numbers
set number

" Allow unsaved buffers in background
set hidden

" Visual command completion
set wildmenu

" Keep 5 lines visible around cursor
set scrolloff=5

" Faster escape key handling
set ttimeout
set ttimeoutlen=100

" {{{ Folding

" Disable folding
set nofoldenable

" Enable folding by fold markers
"set foldmethod=marker

" Autoclose folds, when moving out of them
"set foldclose=all

" Jump 5 lines when running out of the screen
"set scrolljump=5
