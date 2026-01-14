-- Minimal neovim config for tmux-central
-- Focused on markdown viewing with render-markdown.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoread = true
vim.opt.updatetime = 300
vim.opt.termguicolors = true
vim.opt.conceallevel = 2

-- Auto-refresh file when it changes on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

-- Load plugins
require("lazy").setup("plugins")
