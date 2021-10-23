local present, packer = pcall(require, "utils.plugins")

if not present then
   return false
end

local use = packer.use
local use_rocks = packer.use_rocks

local config = function(name)
  return string.format("require('plugins.%s')", name)
end

local use_with_config = function(path, name)
  use({ path, config = config(name) })
end

-- cfilter plugin allows filter down an existing quickfix list
vim.cmd 'packadd! cfilter'

return packer.startup(function()
  use_rocks { 'penlight' }
  -- Managing Packer Updates
  use { 'wbthomason/packer.nvim', opt=true }

  --- Start Plugins {{{
  use {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    {
      'famiu/feline.nvim',
      config = function()
        require "plugins.feline"
      end
    },
    {
      'akinsho/bufferline.nvim',
      config = function()
        require "plugins.bufferline"
      end
    },
  }
  -- }}}

  -- LSP {{{
  use {
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require "plugins.lsp"
      end,
    },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
    { 'folke/lua-dev.nvim' },
    {
      'RRethy/vim-illuminate',
      config = function()
        global.map("n", "<A-n>", '<cmd> lua require"illuminate".next_reference{wrap=true}<CR>')
        global.map("n", "<A-p>", '<cmd> lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>')
      end,
    },
    {
      'windwp/lsp-fastaction.nvim',
      config = function()
        require "plugins.fastaction"
      end
    },
    {
      'ray-x/lsp_signature.nvim',
      config = function()
        require('lsp_signature').setup {
          bind = true,
          fix_pos = function(signatures, _) -- second argument is the client
            return signatures[1].activeParameter >= 0 and signatures[1].parameters > 1
          end,
          hint_enable = false,
          handler_opts = { border = 'rounded' },
        }
      end,
    }
  }
  -- }}}

  -- Completetion {{{
  use {
    use {
      'hrsh7th/nvim-cmp',
      module = 'cmp',
      event = 'InsertEnter',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'f3fora/cmp-spell', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      },
      config = function()
        require "plugins.cmp"
      end
    },
    use {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      module = 'luasnip',
      config = function()
        require "plugins.luasnip"
      end
    },
    use {
      'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      config = function()
        require('nvim-autopairs').setup {
          close_triple_quotes = true,
          check_ts = false,
        }
        require('nvim-autopairs.completion.cmp').setup {
          map_cr = true, --  map <CR> on insert mode
          map_complete = true, -- it will auto insert `(` after select function or method item
          auto_select = true, -- automatically select the first item
        }
      end,
    },
    {
      'abecodes/tabout.nvim',
      after = { 'nvim-cmp' },
      wants = { 'nvim-treesitter' },
      config = function()
        require('tabout').setup {
          completion = false,
          ignore_beginning = false,
        }
      end,
    }
  }
  -- }}}

  -- Treesitter {{{
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufReadPre',
      requires = {
        { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
        { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      },
      config = function()
        require "plugins.treesitter"
      end
    },
    {
      'David-Kunz/treesitter-unit',
      config = function()
        global.map('x', 'iu', ':lua require"treesitter-unit".select()<CR>')
        global.map('x', 'au', ':lua require"treesitter-unit".select(true)<CR>')
        global.map('o', 'iu', '<Cmd>lua require"treesitter-unit".select()<CR>')
        global.map('o', 'au', '<Cmd>lua require"treesitter-unit".select(true)<CR>')
      end,
    },
    {
      'lewis6991/spellsitter.nvim',
      config = function()
        require('spellsitter').setup {
          captures = { 'comment', 'string' },
        }
      end,
    },
  }
  -- }}}

end)
