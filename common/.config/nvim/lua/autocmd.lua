-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd('Filetype', {
--   desc = 'Use tabs in makefiles',
--   pattern = 'make',
--   callback = function()
--     vim.opt_local.expandtab = false
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.tabstop = 4
--   end,
-- })
