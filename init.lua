require("config.lazy")
require("config.keymaps")
require("config.options")


vim.g.augment_workspace_folders = {'~/Documents/swe/puzzle-piece-app/', '~/Documents/swe/puzzle-piece-backend/', '~/Documents/swe/paygee/'}

-- Set tab width to 2 spaces
vim.opt.tabstop = 2        -- Width of a tab character
vim.opt.shiftwidth = 2     -- Width of indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.softtabstop = 2    -- Number of spaces per tab when editing
