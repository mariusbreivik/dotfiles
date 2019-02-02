" Syntax highlight
syntax on

" Use Vim defaults
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=2

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

" We have a fast TTY
set ttyfast

" Enable UTF-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-8859-1

" Do not wrap lines automatically
"set nowrap

" Linewidth to endless
set textwidth=0

set autoindent
set smartindent
filetype indent on

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

" {{{ Folding

" Disable folding
set nofoldenable

" Enable folding by fold markers
"set foldmethod=marker

" Autoclose folds, when moving out of them
"set foldclose=all

" Jump 5 lines when running out of the screen
"set scrolljump=5