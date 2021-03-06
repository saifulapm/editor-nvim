local present, packer = pcall(require, 'utils.plugins')

if not present then
  return false
end

local use = packer.use
local use_rocks = packer.use_rocks

-- cfilter plugin allows filter down an existing quickfix list
vim.cmd 'packadd! cfilter'

return packer.startup(function()
  use_rocks { 'penlight' }

  -- Core Plugin {{{
  use {
    { 'wbthomason/packer.nvim', opt = true },
    { 'nvim-lua/plenary.nvim' },
    { 'lewis6991/impatient.nvim' },
    {
      'nathom/filetype.nvim',
      config = function()
        require('filetype').setup {
          overrides = {
            literal = {
              ['kitty.conf'] = 'kitty',
              ['.gitignore'] = 'conf',
              ['.env'] = 'sh',
            },
          },
        }
      end,
    },
    {
      'NvChad/nvim-base16.lua',
      config = function()
        require('colors').init()
      end,
    },
  }
  -- }}}

  -- UI Plugin {{{
  use {
    { 'kyazdani42/nvim-web-devicons' },
    {
      'feline-nvim/feline.nvim',
      after = 'nvim-base16.lua',
      config = function()
        require 'plugins.feline'
      end,
    },
    {
      'akinsho/bufferline.nvim',
      after = 'nvim-base16.lua',
      config = function()
        require 'plugins.bufferline'
      end,
    },
    {
      'kyazdani42/nvim-tree.lua',
      requires = 'nvim-web-devicons',
      config = function()
        require 'plugins.nvimtree'
      end,
    },
    {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup {
          input = {
            insert_only = false,
          },
          select = {
            telescope = {
              theme = 'cursor',
            },
          },
        }
      end,
    },
    {
      'xiyaowong/nvim-cursorword',
      config = function()
        vim.g.cursorword_disable_filetypes = { 'NvimTree' }
      end,
    },
  }
  -- }}}

  -- LSP {{{
  use {
    {
      'neovim/nvim-lspconfig',
      config = function()
        require 'plugins.lsp'
      end,
      requires = {
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
        { 'b0o/schemastore.nvim' },
        { 'folke/lua-dev.nvim' },
      },
    },
    {
      'ray-x/lsp_signature.nvim',
      config = function()
        require('lsp_signature').setup {
          bind = true,
          fix_pos = false,
          auto_close_after = 15,
          hint_enable = false,
          handler_opts = { border = 'rounded' },
        }
      end,
    },
    {
      'folke/trouble.nvim',
      keys = { '<leader>ld' },
      cmd = { 'TroubleToggle' },
      requires = 'nvim-web-devicons',
      config = function()
        local trouble = require 'trouble'
        global.map('n', '<leader>ld', '<cmd>TroubleToggle lsp_workspace_diagnostics<CR>')
        global.map('n', '<leader>lr', '<cmd>TroubleToggle lsp_references<CR>')
        global.map('n', ']t', function()
          trouble.previous { skip_groups = true, jump = true }
        end)
        global.map('n', '[t', function()
          trouble.next { skip_groups = true, jump = true }
        end)
        trouble.setup { auto_close = true, auto_preview = false }
      end,
    },
    {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {
          width = 120,
          height = 30,
          default_mappings = true,
          border = { '???', '???', '???', '???', '???', '???', '???', '???' },
        }
      end,
      keys = { 'gpd', 'gpi', 'gpr', 'gP' },
    },
    {
      'simrat39/symbols-outline.nvim',
      cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose' },
    },
  }
  -- }}}

  -- Completetion {{{
  use {
    {
      'hrsh7th/nvim-cmp',
      -- module = 'cmp',
      event = { 'InsertEnter', 'CmdlineEnter' },
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'f3fora/cmp-spell', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        -- { 'tzachar/cmp-tabnine', run = './install.sh', after = 'nvim-cmp' },
        -- {
        --   'tzachar/cmp-fuzzy-path',
        --   after = 'cmp-path',
        --   requires = { 'hrsh7th/cmp-path', 'tzachar/fuzzy.nvim' },
        -- },
        -- {
        --   'tzachar/cmp-fuzzy-buffer',
        --   after = 'nvim-cmp',
        --   requires = { 'tzachar/fuzzy.nvim' },
        -- },
      },
      config = function()
        require 'plugins.cmp'
      end,
    },
    {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      module = 'luasnip',
      config = function()
        require 'plugins.luasnip'
      end,
    },
    {
      'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      config = function()
        require('nvim-autopairs').setup {
          close_triple_quotes = true,
          check_ts = false,
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
    },
    {
      'mattn/emmet-vim',
      cmd = 'EmmetInstall',
      setup = function()
        vim.g.user_emmet_complete_tag = 0
        vim.g.user_emmet_install_global = 0
        vim.g.user_emmet_install_command = 0
        vim.g.user_emmet_mode = 'i'
      end,
    },
    {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      keys = { '<c-p>', '<leader>fo', '<leader>ff', '<leader>fs' },
      module_pattern = 'telescope.*',
      config = function()
        require 'plugins.telescope'
      end,
      requires = {
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
          after = 'telescope.nvim',
          config = function()
            require('telescope').load_extension 'fzf'
          end,
        },
        {
          'nvim-telescope/telescope-frecency.nvim',
          after = 'telescope.nvim',
          requires = 'tami5/sqlite.lua',
        },
        {
          'camgraff/telescope-tmux.nvim',
          after = 'telescope.nvim',
          config = function()
            require('telescope').load_extension 'tmux'
          end,
        },
        {
          'nvim-telescope/telescope-smart-history.nvim',
          after = 'telescope.nvim',
          config = function()
            require('telescope').load_extension 'smart_history'
          end,
        },
        -- {
        --   'nvim-telescope/telescope-ui-select.nvim',
        --   after = 'telescope.nvim',
        --   config = function()
        --     require('telescope').load_extension 'ui-select'
        --   end,
        -- },
      },
    },
    use {
      'github/copilot.vim',
      config = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_tab_fallback = ''
        vim.g.copilot_filetypes = {
          ['*'] = false,
          gitcommit = false,
          NeogitCommitMessage = false,
          dart = true,
          lua = true,
          php = true,
          javascript = true,
        }
        global.map('i', '<c-h>', [[copilot#Accept("\<CR>")]], { expr = true, script = true })
      end,
    },
  }
  -- }}}

  -- Debugger {{{
  use {
    {
      'mfussenegger/nvim-dap',
      config = function()
        require 'plugins.dap'
      end,
    },
    { 'nvim-telescope/telescope-dap.nvim' },
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup()
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup()
      end,
    },
  }
  -- }}}

  -- Treesitter {{{
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufReadPre',
      branch = '0.5-compat',
      requires = {
        { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
        {
          'nvim-treesitter/nvim-treesitter-textobjects',
          branch = '0.5-compat',
          after = 'nvim-treesitter',
        },
      },
      config = function()
        require 'plugins.treesitter'
      end,
    },
    {
      'David-Kunz/treesitter-unit',
      after = 'nvim-treesitter',
      config = function()
        global.map('x', 'iu', ':lua require"treesitter-unit".select()<CR>')
        global.map('x', 'au', ':lua require"treesitter-unit".select(true)<CR>')
        global.map('o', 'iu', '<Cmd>lua require"treesitter-unit".select()<CR>')
        global.map('o', 'au', '<Cmd>lua require"treesitter-unit".select(true)<CR>')
      end,
    },
  }
  -- }}}

  --  Git {{{
  use {
    {
      'lewis6991/gitsigns.nvim',
      opt = true,
      config = function()
        require 'plugins.gitsigns'
      end,
      setup = function()
        require('utils').lazy 'gitsigns.nvim'
      end,
    },
    {
      'ruifm/gitlinker.nvim',
      keys = { '<localleader>gu', '<localleader>go' },
      config = function()
        local linker = require 'gitlinker'
        linker.setup { mappings = '<localleader>gu' }
        global.map('n', '<localleader>go', function()
          linker.get_repo_url { action_callback = require('gitlinker.actions').open_in_browser }
        end)
      end,
    },
    {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      keys = { '<localleader>gs', '<localleader>gl', '<localleader>gp' },
      config = function()
        local neogit = require 'neogit'
        neogit.setup {
          disable_signs = false,
          disable_hint = true,
          disable_commit_confirmation = true,
          disable_builtin_notifications = true,
          disable_insert_on_commit = false,
          signs = {
            section = { '', '' }, -- "???", "???"
            item = { '???', '???' },
            hunk = { '???', '???' },
          },
          integrations = {
            diffview = true,
          },
        }
        global.map('n', '<localleader>gs', function()
          neogit.open()
        end)
        global.map('n', '<localleader>gc', function()
          neogit.open { 'commit' }
        end)
        global.map('n', '<localleader>gl', neogit.popups.pull.create)
        global.map('n', '<localleader>gp', neogit.popups.push.create)
      end,
    },
    {
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      config = function()
        require('diffview').setup {
          enhanced_diff_hl = true,
          key_bindings = {
            file_panel = { q = '<Cmd>DiffviewClose<CR>' },
            view = { q = '<Cmd>DiffviewClose<CR>' },
          },
        }
      end,
    },
  }
  --  }}}

  -- Devs && Profiling {{{
  use {
    { 'nanotee/luv-vimdocs' },
    { 'milisims/nvim-luaref' },
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      config = function()
        vim.g.startuptime_tries = 15
        vim.g.startuptime_exe_args = { '+let g:auto_session_enabled = 0' }
      end,
    },
    { 'rafcamlet/nvim-luapad', cmd = 'Luapad' },
  }
  -- }}}

  -- TPOPE {{{
  use {
    { 'tpope/vim-repeat', event = 'BufRead' },
    { 'tpope/vim-apathy', ft = { 'go', 'python', 'javascript', 'typescript' } },
    { 'tpope/vim-surround', event = 'BufRead' },
    {
      'tpope/vim-eunuch',
      cmd = { 'Delete', 'Move', 'Rename', 'Chmod', 'Mkdir', 'Wall', 'SudoWrite', 'SudoEdit' },
    },
    { 'tpope/vim-sleuth', event = 'BufReadPre' },
    {
      'tpope/vim-abolish',
      config = function()
        local opts = { silent = false }
        global.map('n', '<localleader>[', ':S/<C-R><C-W>//<LEFT>', opts)
        global.map('n', '<localleader>]', ':%S/<C-r><C-w>//c<left><left>', opts)
        global.map('n', '<localleader>[', [["zy:%S/<C-r><C-o>"//c<left><left>]], opts)
      end,
      setup = function()
        require('utils').lazy 'vim-abolish'
      end,
      opt = true,
    },
    {
      'tpope/vim-projectionist',
      event = 'BufRead',
      config = function()
        require 'plugins.projectionist'
      end,
    },
  }
  -- }}}

  -- Filetype Plugins {{{
  use {
    { 'dart-lang/dart-vim-plugin' },
    { 'akinsho/flutter-tools.nvim' },
    { 'plasticboy/vim-markdown', ft = 'markdown' },
    {
      'iamcco/markdown-preview.nvim',
      ft = 'markdown',
      run = 'cd app && npm install',
      config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
      end,
    },
  }
  -- }}}

  -- QuickFix {{{
  use {
    { 'kevinhwang91/nvim-bqf', ft = 'qf' },
    {
      'https://gitlab.com/yorickpeterse/nvim-pqf',
      ft = 'qf',
      config = function()
        require('pqf').setup {}
      end,
    },
  }
  -- }}}

  -- Clipboard {{{
  use {
    {
      'AckslD/nvim-neoclip.lua',
      event = 'BufRead',
      disable = true,
      config = function()
        require('neoclip').setup {
          enable_persistant_history = true,
          db_path = vim.fn.stdpath 'data' .. '/neoclip.sqlite3',
          keys = {
            telescope = {
              i = { select = '<CR>', paste = '<c-p>', paste_behind = '<c-k>' },
              n = { select = '<CR>', paste = 'p', paste_behind = 'P' },
            },
          },
        }
      end,
    },
    {
      'kevinhwang91/nvim-hclipboard',
      event = 'BufRead',
      config = function()
        require('hclipboard').start()
      end,
    },
  }
  -- }}}

  -- Editor Support {{{
  use {
    {
      'chentau/marks.nvim',
      event = 'BufRead',
      config = function()
        require('marks').setup {
          -- builtin_marks = { '.', '^' },
          bookmark_0 = {
            sign = '???',
            virt_text = 'bookmarks',
          },
        }
      end,
    },
    {
      'arecarn/vim-fold-cycle',
      event = 'BufRead',
      config = function()
        vim.g.fold_cycle_default_mapping = 0
        global.map('n', '<BS>', '<Plug>(fold-cycle-close)', { noremap = false })
      end,
    },
    { 'AndrewRadev/splitjoin.vim', keys = { 'gS', 'gJ' } },
    {
      'karb94/neoscroll.nvim',
      keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', 'zt', 'zz', 'zb' },
      config = function()
        require('neoscroll').setup {
          mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', 'zt', 'zz', 'zb' },
          stop_eof = false,
          hide_cursor = true,
        }
      end,
    },
    {
      'max397574/better-escape.nvim',
      event = 'InsertEnter',
      config = function()
        require('better_escape').setup()
      end,
    },
    {
      'numToStr/Comment.nvim',
      event = 'BufRead',
      config = function()
        require('Comment').setup()
      end,
    },
    {
      'folke/todo-comments.nvim',
      setup = function()
        require('utils').lazy 'todo-comments.nvim'
      end,
      opt = true,
      config = function()
        require('todo-comments').setup {
          highlight = {
            exclude = { 'org', 'orgagenda', 'vimwiki', 'markdown' },
          },
        }
        global.map('n', '<leader>lt', '<Cmd>TodoTrouble<CR>')
      end,
    },
    {
      'rmagatti/auto-session',
      cmd = { 'RestoreSession', 'SaveSession' },
      config = function()
        require('auto-session').setup {
          auto_session_root_dir = ('%s/session/auto/'):format(vim.fn.stdpath 'data'),
        }
      end,
    },
    {
      'svermeulen/vim-subversive',
      config = function()
        global.map('n', 'S', '<plug>(SubversiveSubstitute)', { noremap = false })
      end,
      setup = function()
        require('utils').lazy 'vim-subversive'
      end,
      opt = true,
    },
    {
      'tommcdo/vim-exchange',
      config = function()
        vim.g.exchange_no_mappings = 1
        global.map({ 'n', 'x' }, 'X', '<Plug>(Exchange)', { noremap = false })
        global.map('n', 'Xc', '<Plug>(ExchangeClear)', { noremap = false })
      end,
      setup = function()
        require('utils').lazy 'vim-exchange'
      end,
      opt = true,
    },
    {
      'christoomey/vim-tmux-navigator',
      config = function()
        vim.g.tmux_navigator_no_mappings = 1
        global.map('n', '<C-H>', '<cmd>TmuxNavigateLeft<cr>')
        global.map('n', '<C-J>', '<cmd>TmuxNavigateDown<cr>')
        global.map('n', '<C-K>', '<cmd>TmuxNavigateUp<cr>')
        global.map('n', '<C-L>', '<cmd>TmuxNavigateRight<cr>')
        -- Disable tmux navigator when zooming the Vim pane
        vim.g.tmux_navigator_disable_when_zoomed = 1
        vim.g.tmux_navigator_preserve_zoom = 1
        vim.g.tmux_navigator_save_on_switch = 2
      end,
      setup = function()
        require('utils').lazy 'vim-tmux-navigator'
      end,
      opt = true,
    },
    {
      'haya14busa/vim-asterisk',
      event = 'BufReadPre',
      config = function()
        global.map({ 'n', 'v' }, '*', '<Plug>(asterisk-*)', { noremap = false })
        global.map({ 'n', 'v' }, '#', '<Plug>(asterisk-#)', { noremap = false })
      end,
    },
    {
      'itchyny/vim-highlighturl',
      event = 'BufRead',
      config = function()
        vim.g.highlighturl_guifg = '#51afef'
      end,
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = function()
        require 'plugins.blankline'
      end,
    },
    {
      'rhysd/conflict-marker.vim',
      event = 'BufReadPre',
      config = function()
        -- disable the default highlight group
        vim.g.conflict_marker_highlight_group = ''
        -- Include text after begin and end markers
        vim.g.conflict_marker_begin = '^<<<<<<< .*$'
        vim.g.conflict_marker_end = '^>>>>>>> .*$'
      end,
    },
    {
      'norcalli/nvim-colorizer.lua',
      cmd = {
        'ColorizerToggle',
        'ColorizerAttachToBuffer',
        'ColorizerDetachFromBuffer',
        'ColorizerReloadAllBuffers',
      },
      ft = { 'html', 'css', 'sass', 'vim', 'typescript', 'typescriptreact' },
      config = function()
        require('colorizer').setup {
          css = { rgb_fn = true },
          scss = { rgb_fn = true },
          sass = { rgb_fn = true },
          stylus = { rgb_fn = true },
          vim = { names = true },
          tmux = { names = false },
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          html = {
            mode = 'foreground',
          },
        }
      end,
    },
    {
      'mg979/vim-visual-multi',
      keys = '<C-e>',
      config = function()
        vim.g.VM_highlight_matches = 'underline'
        vim.g.VM_theme = 'codedark'
        vim.g.VM_maps = {
          ['Find Under'] = '<C-e>',
          ['Find Subword Under'] = '<C-e>',
          ['Select Cursor Down'] = '\\j',
          ['Select Cursor Up'] = '\\k',
        }
      end,
    },
    {
      'gpanders/editorconfig.nvim',
      setup = function()
        require('utils').lazy 'editorconfig.nvim'
      end,
      opt = true,
    },
    {
      'monaqa/dial.nvim',
      keys = { { 'n', '-' }, { 'n', '+' }, { 'v', '-' }, { 'v', '+' } },
      config = function()
        local dial = require 'dial'

        dial.augends['custom#boolean'] = dial.common.enum_cyclic {
          name = 'boolean',
          strlist = { 'true', 'false' },
        }
        table.insert(dial.config.searchlist.normal, 'custom#boolean')

        global.map({ 'n', 'v' }, '+', '<Plug>(dial-increment)', { noremap = false })
        global.map({ 'n', 'v' }, '-', '<Plug>(dial-decrement)', { noremap = false })
      end,
    },
    {
      'andymass/vim-matchup',
      opt = true,
      setup = function()
        require('utils').lazy 'vim-matchup'
      end,
    },
    {
      'lewis6991/spaceless.nvim',
      event = 'InsertEnter',
      config = function()
        require('spaceless').setup()
      end,
    },
  }
  -- }}}

  -- Tools {{{
  use {
    {
      'soywod/himalaya',
      cmd = 'Himalaya',
      rtp = 'email-manager/vim',
    },
    {
      'numToStr/FTerm.nvim',
      config = function()
        require('FTerm').setup {
          border = 'single',
          dimensions = {
            height = 0.6,
            width = 0.9,
          },
        }
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
        map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
      end,
    },
    {
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      config = function()
        vim.g.undotree_TreeNodeShape = '???' -- Alternative: '???'
        vim.g.undotree_SetFocusWhenToggle = 1
      end,
    },
    {
      'vimwiki/vimwiki',
      keys = { '<leader>ww', '<leader>wt', '<leader>wi' },
      event = { 'BufEnter *.wiki' },
      setup = function()
        require('plugins.vimwiki').setup()
      end,
      config = function()
        require('plugins.vimwiki').config()
      end,
    },
  }
  -- }}}

  -- Operators {{{
  use {
    {
      'phaazon/hop.nvim',
      keys = { { 'n', 's' }, 'f', 'F' },
      config = function()
        local hop = require 'hop'
        -- remove h,j,k,l from hops list of keys
        hop.setup { keys = 'etovxqpdygfbzcisuran' }
        global.map('n', 's', hop.hint_char1)
        global.map({ 'x', 'n' }, 'F', function()
          hop.hint_char1 {
            direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
            current_line_only = true,
            inclusive_jump = false,
          }
        end)
        global.map({ 'x', 'n' }, 'f', function()
          hop.hint_char1 {
            direction = require('hop.hint').HintDirection.AFTER_CURSOR,
            current_line_only = true,
            inclusive_jump = false,
          }
        end)
        global.map('o', 'F', function()
          hop.hint_char1 {
            direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
            current_line_only = true,
            inclusive_jump = true,
          }
        end)
        global.map('o', 'f', function()
          hop.hint_char1 {
            direction = require('hop.hint').HintDirection.AFTER_CURSOR,
            current_line_only = true,
            inclusive_jump = true,
          }
        end)
      end,
    },
    { 'kana/vim-operator-user' },
    {
      'kana/vim-operator-replace',
      keys = { { 'x', 'p' } },
      config = function()
        vim.api.nvim_set_keymap('x', 'p', '<Plug>(operator-replace)', { silent = true })
      end,
    },
    {
      'glts/vim-textobj-comment',
      event = 'BufRead',
      config = function()
        vim.g.textobj_comment_no_default_key_mappings = 1
        global.map('x', 'ax', '<Plug>(textobj-comment-a)', { noremap = false })
        global.map('o', 'ax', '<Plug>(textobj-comment-a)', { noremap = false })
        global.map('x', 'ix', '<Plug>(textobj-comment-i)', { noremap = false })
        global.map('o', 'ix', '<Plug>(textobj-comment-i)', { noremap = false })
      end,
    },
    { 'rhysd/vim-operator-surround', event = 'BufRead' },
    {
      'kana/vim-niceblock',
      event = 'BufRead',
      config = function()
        global.map('x', 'I', '<Plug>(niceblock-I)', { noremap = false })
        global.map('x', 'gI', '<Plug>(niceblock-gI)', { noremap = false })
        global.map('x', 'A', '<Plug>(niceblock-A)', { noremap = false })
      end,
    },
  }
  -- }}}

  -- Personal Plugins {{{
  -- use {
  --   'saifulapm/chartoggle.nvim',
  --   config = function()
  --     require('chartoggle').setup {
  --       leader = '<localleader>',
  --       keys = { ',', ';' },
  --     }
  --   end,
  -- }

  -- use { '~/Sites/neovim/stackflow.nvim' }
  -- use { '~/Sites/neovim/nvim-cheat.sh' }
  -- use { '~/Sites/neovim/popfix' }
  -- }}}
end)
