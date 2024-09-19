# My Neovim Configuration

Welcome to my Neovim setup! This configuration is aimed at providing a modern
and feature-rich development environment using the latest plugins and tools.
Here's a breakdown of what's included and how everything is organized.

## Plugin Overview

### Essential Plugins

- **nvim-lua/plenary.nvim**: A utility library for various plugins.
- **nvim-tree/nvim-web-devicons**: Icons for different file types.
- **norcalli/nvim-colorizer.lua**: Color highlighting for color codes.
- **nvim-lualine/lualine.nvim**: A fast and easy-to-configure statusline.

### Syntax Highlighting & Code Navigation

- **nvim-treesitter/nvim-treesitter**: Advanced syntax highlighting and code
  navigation.
- **nvim-lspconfig**: Easily configure language servers.
- **williamboman/mason.nvim**: Manage external tools and language servers.

### Code Completion & Snippets

- **hrsh7th/nvim-cmp**: A powerful code completion engine.
- **L3MON4D3/LuaSnip**: Snippet engine for Neovim.
- **saadparwaiz1/cmp_luasnip**: Integrates LuaSnip with nvim-cmp.

### Debugging & Testing

- **mfussenegger/nvim-dap**: A Debug Adapter Protocol client for Neovim.
- **nvim-neotest/neotest**: A framework for running tests within Neovim.

### UI Enhancements

- **nvim-telescope/telescope.nvim**: A fuzzy finder for files, buffers, and
  more.
- **petertriho/nvim-scrollbar**: Adds a scrollbar with visual indicators.
- **kevinhwang91/nvim-hlslens**: Better search highlighting.
- **ggandor/leap.nvim**: Easier navigation within files.

### Git Integration

- **lewis6991/gitsigns.nvim**: Git integration for buffers.
- **kdheepak/lazygit.nvim**: Lazygit integration for Neovim.
- **FabijanZulj/blame.nvim**: Displays git blame information.

### Miscellaneous

- **folke/which-key.nvim**: Displays available keybindings.
- **numToStr/Comment.nvim**: Easily comment out code.
- **echasnovski/mini.nvim**: A collection of various modules like `mini.ai`,
  `mini.align`, and `mini.move`.
- **kylechui/nvim-surround**: Adds surround commands for editing surrounding
  characters.
- **Saecki/crates.nvim**: Helps with Rust crates and version management.
- **JoosepAlviste/palenightfall.nvim**: A beautiful and customizable theme.

## Installation

This configuration is organized using
[lazy.nvim](https://github.com/folke/lazy.nvim). To get started, make sure you
have Neovim 0.8 or newer, and clone this repository to config path.

