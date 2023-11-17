local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    return false
  end
  
  local packer_bootstrap = ensure_packer()

  vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)

    use("wbthomason/packer.nvim") -- packer
    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
    use("christoomey/vim-tmux-navigator") --split window navigation
    use("szw/vim-maximizer") -- maximizes and restore current window
    use("tpope/vim-surround")
    use("vim-scripts/ReplaceWithRegister")
    use("numToStr/Comment.nvim")
    use("nvim-tree/nvim-tree.lua") -- file explorer
    use("kyazdani42/nvim-web-devicons") --vscode icons
    use("nvim-lualine/lualine.nvim") --statusline
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

    --colorschemes
    use("Shatur/neovim-ayu") 
    use("k4yt3x/ayu-vim-darker")
    use("Alexis12119/nightly.nvim")
    use("folke/tokyonight.nvim")

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    --managing & installing lsp servers
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    --configuring lsp servers
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use({
    "glepnir/lspsaga.nvim",
      branch = "main",
      requires = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" },
      },
    }) -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim")
    use("onsails/lspkind.nvim")

   --treesitter 
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
      end,
    })

    --auto closing
    use("windwp/nvim-autopairs")
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

    --git signs plugin
    use("lewis6991/gitsigns.nvim")

    --toggle terminal
    use({"akinsho/toggleterm.nvim", tag = "*"})

    -- deal with sessions    
    use("rmagatti/auto-session")
    
    use({
      "rmagatti/session-lens",
      requires = {"nvim-telescope/telescope.nvim"},
    })

    if packer_bootstrap then
        require("packer").sync()
      end
end)
