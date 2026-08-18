return {
  'tpope/vim-fugitive',
  key = { '<leader>gs' },
  cmd = { 'G', 'Git', 'Gdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse', 'GRemove', 'GRename', 'Glgrep', 'Gedit' },
  keys = {
    {
      '<leader>gg',
      function()
        vim.cmd 'G'
      end,
      desc = '[G]it status',
    },
    {
      '<leader>gc',
      function()
        vim.cmd 'Git commit'
      end,
      desc = '[G]it [c]ommit',
    },
    {
      '<leader>gA',
      function()
        vim.cmd 'Git add .'
      end,
      desc = '[G]it [a]dd all',
    },
    {
      '<leader>ga',
      function()
        vim.cmd 'Git add %'
      end,
      desc = '[G]it [a]dd current',
    },
    {
      '<leader>gl',
      function()
        vim.cmd 'Git log --pretty=format:"%h - %d %s (%cr) <%an>" --oneline --graph'
      end,
      desc = '[G]it [l]og',
    },
    {
      '<leader>gs',
      function()
        vim.cmd 'Git pull'
        vim.cmd 'Git push'
      end,
      desc = '[G]it [s]sync (pull&push)',
    },
    {
      '<leader>gps',
      function()
        vim.cmd 'Git push'
      end,
      desc = '[G]it [p]u[s]h',
    },
    {
      '<leader>gpl',
      function()
        vim.cmd 'Git pull'
      end,
      desc = '[G]it [p]u[l]l',
    },
  },
}
