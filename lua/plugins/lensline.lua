return {
  'oribarilan/lensline.nvim',
  tag = '1.0.0', -- or: branch = 'release/1.x' for latest non-breaking updates
  lazy = true,
  config = function()
    require("lensline").setup()
  end,
}
