" Map é (and è à ê?) to useful keys (won't work with Ctrl)
nnoremap é w
onoremap ié iw
onoremap iÉ iW
onoremap aé aw
onoremap aÉ aW
vnoremap é w

" Reach some chars more easily while editing (<, >)
noremap! æ <
noremap! ù >

" Space is the leader
let mapleader=" "

" Windowing management
nnoremap <Leader>c <c-w>h
nnoremap <Leader>t <c-w>j
nnoremap <Leader>s <c-w>k
nnoremap <Leader>r <c-w>l

nnoremap <Leader>g <c-]>
nnoremap <Leader>vg :vs<CR><c-]>

" Tab management
nnoremap <Leader>i :tabnext<CR>
nnoremap <Leader>u :tabprevious<CR>

" Writing and quitting
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Remove trailing whitespaces (should be done automatically after a write)
nnoremap <Leader><Tab> :%s/\s\+$//g<CR>:w<CR>

" Rebind home row using Alt
execute "set <M-c>=\ec"
execute "set <M-t>=\et"
execute "set <M-s>=\es"
execute "set <M-r>=\er"
noremap <M-c> h
noremap <M-t> j
noremap <M-s> k
noremap <M-r> l

" Git
nnoremap <Leader>. :Git grep -q -w <c-r><c-w><CR>
