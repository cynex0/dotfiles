return {
  'mbbill/undotree',
  config = function()
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
  keys = {
    {
      '<leader>u',
      function()
        vim.cmd 'UndotreeToggle'
      end,
      desc = '[U]ndo tree',
    },
  },
}
