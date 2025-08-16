-- Faster scrolling
vim.opt.lazyredraw = true

-- Better splitting 
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 8


-- Diagnostic config
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = true,
})
