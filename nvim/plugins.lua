local execute = vim.api.nvim_command
local fn = vim.fn

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  -- Use vim.loop.fs_stat instead of vim.uv.fs_stat
  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
  'neovim/nvim-lspconfig';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/cmp-vsnip';
  'hrsh7th/vim-vsnip-integ';
  'echasnovski/mini.completion';
  'overcache/NeoSolarized';
  'nvim-treesitter/nvim-treesitter';
  'numToStr/Comment.nvim';
  'vim-airline/vim-airline';
  'vim-airline/vim-airline-themes';
  'tpope/vim-fugitive';
  'airblade/vim-gitgutter';
  'nvim-telescope/telescope.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-lua/popup.nvim';
  'f-person/git-blame.nvim';
  'stevearc/conform.nvim';
  'saadparwaiz1/cmp_luasnip'; -- Snippets source for nvim-cmp
  'L3MON4D3/LuaSnip'; -- Snippets plugin
  'supermaven-inc/supermaven-nvim';
  'olimorris/codecompanion.nvim';
}
