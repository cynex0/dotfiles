return {
  'declancm/cinnamon.nvim',
  version = '*', -- use latest release
  config = function()
    local cinnamon = require 'cinnamon'
    cinnamon.setup {
      disabled = false,
      keymaps = {
        -- Enable the provided 'basic' keymaps
        basic = true,
        -- Enable the provided 'extra' keymaps
        extra = false,
      },
      options = {
        max_delta = {
          time = 100,
        },
        delay = 4,
      },
    }

    vim.keymap.set('n', '<C-U>', function()
      cinnamon.scroll '<C-U>zz'
    end)
    vim.keymap.set('n', '<C-D>', function()
      cinnamon.scroll '<C-D>zz'
    end)

    -- LSP:
    vim.keymap.set('n', 'gd', function()
      cinnamon.scroll(vim.lsp.buf.definition)
    end)
    vim.keymap.set('n', 'gD', function()
      cinnamon.scroll(vim.lsp.buf.declaration)
    end)
  end,
}
