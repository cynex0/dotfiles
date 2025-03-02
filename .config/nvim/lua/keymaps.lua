local map = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[Custom Keymaps]]

-- remap nvchad defaults
-- nomap("n", "<leader>pt")
-- nomap("n", "<leader>sh")
map('n', 'Q', '<nop>') -- unmap Q

-- map('n', ';', ':', { desc = 'CMD enter command mode' })
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd> w <cr>')
--
-- move lines down/up
map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- cursor positions
-- map('n', 'J', 'mzJ`z') -- keep cursor at the same spot on J
-- map('n', '<C-d>', '<C-d>zz') -- keep cursor in the middle of the screen on C-d
-- map('n', '<C-u>', '<C-u>zz') -- keep cursor in the middle of the screen on C-d

map('x', '<leader>p', '"_dP', { desc = 'Paste over' })
map('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
map('n', '<leader>P', '"*p', { desc = 'Paste from selection' })

map('n', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
map('v', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
map('n', '<leader>Y', '"+Y', { desc = 'Yank to clipboard' })

map('n', '<leader>n', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace word' })

map('n', '<A-p>', '<cmd>cprev<CR>', { desc = 'Quikfix: [p]rev' })
map('n', '<A-n>', '<cmd>cnext<CR>', { desc = 'Quikfix: [n]ext' })

-- stupid maps for stupid course
map('n', '<leader>mm', "<cmd>execute 'w! main.' . expand('%:e')<CR>", { desc = 'Save as main' })
map('n', '<leader>mx', '<cmd>%!xxd<CR>', { desc = 'Hex dump' })
