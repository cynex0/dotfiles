return {
  'jasonpanosso/harpoon-tabline.nvim',
  requires = { { 'ThePrimeagen/harpoon' } },
  config = function()
    require('harpoon-tabline').setup()
  end,
}
