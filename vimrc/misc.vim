set nocompatible
set number
set relativenumber
set hlsearch
set tabstop=8 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set scrolloff=15
set colorcolumn=100
set backspace=indent,eol,start
set ignorecase
set showcmd
set nomodeline

" Show help vertically
autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif

" Enable manpages
runtime ftplugin/man.vim

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
