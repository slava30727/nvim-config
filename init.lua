local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    "folke/which-key.nvim",
    "navarasu/onedark.nvim",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require "nvim-treesitter.configs"

            configs.setup({
                ensure_installed = {
                    "c", "cpp", "lua", "rust", "python",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort = { sorter = "case_sensitive" },
                view = { width = 30 },
                renderer = { group_empty = true },
                filters = { dotfiles = true },
            })
        end,
    },
})

require("lualine").setup {
    options = {
        theme = "horizon",
    },
}

require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = { "rust-analyzer" },
}

-- require("lspconfig").sumneko_lua.setup()

-- empty setup using defaults
require("nvim-tree").setup()

local onedark = require("onedark")

onedark.setup {
    style = "warmer",
}

onedark.load()

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python_recomended_style = 0
vim.g.rust_recomended_style = 0
vim.opt.tabstop = 4
vim.opt.smartindent = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.relativenumber = true
vim.wo.number = true


-- optionally enable 24-bit colour
vim.opt.termguicolors = true
