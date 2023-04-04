call plug#begin('~/.vim/plugged')

" Visual
Plug 'nchataing/papercolor-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'
set background=light

" Fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
nnoremap <Leader>p :FZF<CR>
":call fzf#run({'source': 'git ls-files', 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.6 } })<CR>

" Formatting
Plug 'rhysd/vim-clang-format'
let g:clang_format#command = 'clang-format-10'
let g:clang_format#auto_format = 1
let g:clang_format#auto_filetypes = [ "c", "h" ]

" Git galore
Plug 'tpope/vim-fugitive'

" To learn
" Plug 'tpope/vim-surround'

" Zig
" Plug 'ziglang/zig.vim'

call plug#end()

colorscheme PaperColor
