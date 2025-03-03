return {
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    local codeium = require 'codeium'
    local cfg = {
      enable_chat = false,
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        idle_delay = 100,
        key_bindings = {
          accept = '<M-j>',
          accept_word = false,
          accept_line = '<M-J>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
    }
    codeium.setup(cfg)

    vim.g.codeium_enabled = true
    vim.keymap.set('n', '<leader>cl', function()
      vim.g.codeium_enabled = not vim.g.codeium_enabled
      cfg.virtual_text.enabled = vim.g.codeium_enabled
      codeium.setup(cfg)
      print('Codeium ' .. (vim.g.codeium_enabled and 'Enabled' or 'Disabled'))
    end, { desc = 'Toggle Ze [L]LMs' })
  end,
}
