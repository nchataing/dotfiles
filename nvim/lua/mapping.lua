--- Space is the leader ---
vim.g.mapleader = " "

--- Bépo remapping ---

-- é -> w
vim.keymap.set({'n', 'v'}, 'é', 'w')
vim.keymap.set({'n', 'v'}, 'É', 'W')
vim.keymap.set('o', 'ié', 'iw')
vim.keymap.set('o', 'aé', 'aw')
vim.keymap.set('o', 'iÉ', 'iW')
vim.keymap.set('o', 'aÉ', 'aW')

-- home row remapping with alt
vim.keymap.set({'n', 'v'}, '<A-c>', 'h')
vim.keymap.set({'n', 'v'}, '<A-t>', 'j')
vim.keymap.set({'n', 'v'}, '<A-s>', 'k')
vim.keymap.set({'n', 'v'}, '<A-r>', 'l')

-- window navigation
vim.keymap.set('n', '<Leader>c', '<c-w>h')
vim.keymap.set('n', '<Leader>t', '<c-w>j')
vim.keymap.set('n', '<Leader>s', '<c-w>k')
vim.keymap.set('n', '<Leader>r', '<c-w>l')

-- tags / help menu
vim.keymap.set('n', '<Leader>g', '<c-]>')
vim.keymap.set('n', '<Leader>vg', ':vs<CR><c-]>')
vim.keymap.set('n', '<Leader>xg', ':split<CR><c-]>')

-- tab navigation
vim.keymap.set('n', '<Leader>i', ':tabnext<CR>')
vim.keymap.set('n', '<Leader>u', ':tabprevious<CR>')

-- write / quit
vim.keymap.set('n', '<Leader>w', ':w<CR>')
vim.keymap.set('n', '<Leader>q', ':q<CR>')

-- remove trailing whitespaces
vim.keymap.set('n', '<Leader><Tab>', ':%s/\\s\\+$//g<CR>:w<CR>:noh<CR>')

-- open in same directory
vim.keymap.set('n', ',e', ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<Leader>xt', ':split term://zsh<CR>i')
vim.keymap.set('n', '<Leader>vt', ':vsplit term://zsh<CR>i')

