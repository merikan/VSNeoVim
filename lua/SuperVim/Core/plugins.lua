local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use "wbthomason/packer.nvim"
  -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/popup.nvim"
  -- Useful lua functions used ny lots of plugins
  use "nvim-lua/plenary.nvim"
  -- Icons
  use "kyazdani42/nvim-web-devicons"
  -- File Browser
  use "kyazdani42/nvim-tree.lua"
  -- BufferLine
  use "akinsho/bufferline.nvim"
  -- LuaLine ( status bar )
  use "nvim-lualine/lualine.nvim"
  -- Terminal
  use "akinsho/toggleterm.nvim"
  -- Project
  use "ahmedkhalf/project.nvim"
  -- Impatent
  use "lewis6991/impatient.nvim"
  -- IndentLine
  use "lukas-reineke/indent-blankline.nvim"
  -- Alpha
  use "goolord/alpha-nvim"
  -- This is needed to fix lsp doc highlight
  use "antoinemadec/FixCursorHold.nvim"
  -- WhichKey
  use "folke/which-key.nvim"
  -- AutoCompletion with cmp
  use "hrsh7th/nvim-cmp"
  -- Buffer Completions
  use "hrsh7th/cmp-buffer"
  -- Path Completions
  use "hrsh7th/cmp-path"
  -- CmdLine Completions
  use "hrsh7th/cmp-cmdline"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
