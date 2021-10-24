local present, packer = pcall(require, 'utils.plugins')

if not present then
  return false
end

local use = packer.use
local use_rocks = packer.use_rocks
local map = global.map

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
            },
          },
        }
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
    },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
    { 'folke/lua-dev.nvim' },
    {
      'RRethy/vim-illuminate',
      config = function()
        map('n', '<A-n>', '<cmd> lua require"illuminate".next_reference{wrap=true}<CR>')
        map(
          'n',
          '<A-p>',
          '<cmd> lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>'
        )
      end,
    },
    {
      'windwp/lsp-fastaction.nvim',
      config = function()
        require 'plugins.fastaction'
      end,
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
    },
    {
      'folke/trouble.nvim',
      keys = { '<leader>ld' },
      cmd = { 'TroubleToggle' },
      requires = 'nvim-web-devicons',
      config = function()
        local trouble = require 'trouble'
        map('n', '<leader>ld', '<cmd>TroubleToggle lsp_workspace_diagnostics<CR>')
        map('n', '<leader>lr', '<cmd>TroubleToggle lsp_references<CR>')
        map('n', ']t', function()
          trouble.previous { skip_groups = true, jump = true }
        end)
        map('n', '[t', function()
          trouble.next { skip_groups = true, jump = true }
        end)
        trouble.setup { auto_close = true, auto_preview = false }
      end,
    },
  }
  -- }}}

  -- Completetion {{{
  use {
    {
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
    },
    {
      'mattn/emmet-vim',
      event = 'InsertEnter',
      ft = { 'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript', 'typescriptreact' },
      config = function()
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
      },
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
        map('x', 'iu', ':lua require"treesitter-unit".select()<CR>')
        map('x', 'au', ':lua require"treesitter-unit".select(true)<CR>')
        map('o', 'iu', '<Cmd>lua require"treesitter-unit".select()<CR>')
        map('o', 'au', '<Cmd>lua require"treesitter-unit".select(true)<CR>')
      end,
    },
    {
      'lewis6991/spellsitter.nvim',
      after = 'nvim-treesitter',
      config = function()
        require('spellsitter').setup {
          captures = { 'comment', 'string' },
        }
      end,
    },
  }
  -- }}}

  -- UI Plugin {{{
  use {
    { 'kyazdani42/nvim-web-devicons' },
    {
      'famiu/feline.nvim',
      config = function()
        require 'plugins.feline'
      end,
    },
    {
      'akinsho/bufferline.nvim',
      config = function()
        require 'plugins.bufferline'
      end,
    },
    {
      'kyazdani42/nvim-tree.lua',
      requires = 'nvim-web-devicons',
      config = function()
        require 'plugins.nvim-tree'
      end,
    },
  }
  -- }}}

  --  Git {{{
  use {
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require 'plugins.gitsigns'
      end,
    },
    {
      'ruifm/gitlinker.nvim',
      keys = { '<localleader>gu', '<localleader>go' },
      config = function()
        local linker = require 'gitlinker'
        linker.setup { mappings = '<localleader>gu' }
        map('n', '<localleader>go', function()
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
            section = { '', '' }, -- "", ""
            item = { '▸', '▾' },
            hunk = { '樂', '' },
          },
          integrations = {
            diffview = true,
          },
        }
        map('n', '<localleader>gs', function()
          neogit.open()
        end)
        map('n', '<localleader>gc', function()
          neogit.open { 'commit' }
        end)
        map('n', '<localleader>gl', neogit.popups.pull.create)
        map('n', '<localleader>gp', neogit.popups.push.create)
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
    {
      'pwntester/octo.nvim',
      cmd = 'Octo*',
      setup = function()
        map('n', '<localleader>op', '<cmd>Octo pr list<CR>')
        map('n', '<localleader>ol', '<cmd>Octo issue list<CR>')
      end,
      config = function()
        require('octo').setup()
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
    { 'tpope/vim-repeat' },
    { 'tpope/vim-apathy', ft = { 'go', 'python', 'javascript', 'typescript' } },
    { 'tpope/vim-surround' },
    { 'tpope/vim-eunuch' },
    { 'tpope/vim-sleuth' },
    {
      'tpope/vim-abolish',
      config = function()
        local opts = { silent = false }
        map('n', '<localleader>[', ':S/<C-R><C-W>//<LEFT>', opts)
        map('n', '<localleader>]', ':%S/<C-r><C-w>//c<left><left>', opts)
        map('n', '<localleader>[', [["zy:%S/<C-r><C-o>"//c<left><left>]], opts)
      end,
    },
    {
      'tpope/vim-projectionist',
      config = function()
        require 'plugins.projectionist'
      end,
    },
  }
  -- }}}

  -- Filetype Plugins {{{
  use {
    { 'dart-lang/dart-vim-plugin' },
    { 'plasticboy/vim-markdown' },
    { 'fladson/vim-kitty' },
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
        require('pqf').setup {
          signs = {
            error = '✗',
            warning = '',
            info = '',
            hint = '',
          },
        }
      end,
    },
  }
  -- }}}

  -- Clipboard {{{
  use {
    {
      'AckslD/nvim-neoclip.lua',
      event = 'BufRead',
      config = function()
        require('neoclip').setup {
          enable_persistant_history = true,
          db_path = vim.fn.stdpath 'data' .. '/neoclip.sqlite3',
          keys = {
            i = { select = '<CR>', paste = '<c-p>', paste_behind = '<c-k>' },
            n = { select = '<CR>', paste = 'p', paste_behind = 'P' },
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
      'ahmedkhalf/project.nvim',
      config = function()
        require('project_nvim').setup()
      end,
    },
    {
      'chentau/marks.nvim',
      config = function()
        require('marks').setup {
          -- builtin_marks = { '.', '^' },
          bookmark_0 = {
            sign = '⚑',
            virt_text = 'bookmarks',
          },
        }
      end,
    },
    {
      'arecarn/vim-fold-cycle',
      config = function()
        vim.g.fold_cycle_default_mapping = 0
        map('n', '<BS>', '<Plug>(fold-cycle-close)', { noremap = false })
      end,
    },
    { 'AndrewRadev/splitjoin.vim' },
    {
      'hrsh7th/vim-eft',
      config = function()
        vim.g.eft_ignorecase = true
      end,
    },
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
      'gelguy/wilder.nvim',
      event = { 'CursorHold', 'CmdlineEnter' },
      rocks = { 'luarocks-fetch-gitrec', 'pcre2' },
      requires = { 'romgrk/fzy-lua-native' },
      config = function()
        vim.cmd 'source ~/config/nvim/vimscript/wilder.vim'
      end,
    },
    {
      'folke/todo-comments.nvim',
      after = 'plenary.nvim',
      config = function()
        require('todo-comments').setup {
          highlight = {
            exclude = { 'org', 'orgagenda', 'vimwiki', 'markdown' },
          },
        }
        map('n', '<leader>lt', '<Cmd>TodoTrouble<CR>')
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
        map('n', 'S', '<plug>(SubversiveSubstitute)', { noremap = false })
      end,
    },
    {
      'tommcdo/vim-exchange',
      config = function()
        vim.g.exchange_no_mappings = 1
        map({ 'n', 'x' }, 'X', '<Plug>(Exchange)', { noremap = false })
        map('n', 'Xc', '<Plug>(ExchangeClear)', { noremap = false })
      end,
    },
    {
      'christoomey/vim-tmux-navigator',
      config = function()
        vim.g.tmux_navigator_no_mappings = 1
        map('n', '<C-H>', '<cmd>TmuxNavigateLeft<cr>')
        map('n', '<C-J>', '<cmd>TmuxNavigateDown<cr>')
        map('n', '<C-K>', '<cmd>TmuxNavigateUp<cr>')
        map('n', '<C-L>', '<cmd>TmuxNavigateRight<cr>')
        -- Disable tmux navigator when zooming the Vim pane
        vim.g.tmux_navigator_disable_when_zoomed = 1
        vim.g.tmux_navigator_preserve_zoom = 1
        vim.g.tmux_navigator_save_on_switch = 2
      end,
    },
    {
      'haya14busa/vim-asterisk',
      event = 'BufReadPre',
      config = function()
        map('n', '*', '<Plug>(asterisk-*)', { noremap = false })
        map('n', '#', '<Plug>(asterisk-#)', { noremap = false })
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
    { 'gpanders/editorconfig.nvim' },
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

        map({ 'n', 'v' }, '+', '<Plug>(dial-increment)', { noremap = false })
        map({ 'n', 'v' }, '-', '<Plug>(dial-decrement)', { noremap = false })
      end,
    },
  }
  -- }}}

  -- Tools {{{
  use {
    {
      'soywod/himalaya',
      cmd = 'Himalaya',
      rtp = 'vim',
    },
    {
      'akinsho/toggleterm.nvim',
      config = function()
        require('toggleterm').setup {
          open_mapping = [[<c-\>]],
          shade_filetypes = { 'none' },
          direction = 'vertical',
          start_in_insert = true,
          float_opts = { border = 'curved', winblend = 3 },
          size = function(term)
            if term.direction == 'horizontal' then
              return 15
            elseif term.direction == 'vertical' then
              return math.floor(vim.o.columns * 0.4)
            end
          end,
        }

        local float_handler = function(term)
          if vim.fn.mapcheck('jk', 't') ~= '' then
            vim.api.nvim_buf_del_keymap(term.bufnr, 't', 'jk')
            vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
          end
        end

        local Terminal = require('toggleterm.terminal').Terminal

        local lazygit = Terminal:new {
          cmd = 'lazygit',
          dir = 'git_dir',
          hidden = true,
          direction = 'float',
          on_open = float_handler,
        }

        global.command {
          'Lazygit',
          function()
            lazygit:toggle()
          end,
        }

        local htop = Terminal:new {
          cmd = 'htop',
          hidden = 'true',
          direction = 'float',
          on_open = float_handler,
        }

        global.command {
          'Htop',
          function()
            htop:toggle()
          end,
        }
      end,
    },
    {
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      config = function()
        vim.g.undotree_TreeNodeShape = '◉' -- Alternative: '◦'
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
      keys = { { 'n', 's' }, { 'o', 'f' }, { 'x', 'f' }, { 'o', 'F' }, { 'x', 'F' } },
      config = function()
        local hop = require 'hop'
        -- remove h,j,k,l from hops list of keys
        hop.setup { keys = 'etovxqpdygfbzcisuran' }
        map('n', 's', hop.hint_char1)
        map({ 'o', 'x' }, 'F', function()
          hop.hint_char1 { direction = require('hop.hint').HintDirection.BEFORE_CURSOR }
        end)
        map({ 'o', 'x' }, 'f', function()
          hop.hint_char1 { direction = require('hop.hint').HintDirection.AFTER_CURSOR }
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
        map('x', 'ax', '<Plug>(textobj-comment-a)', { noremap = false })
        map('o', 'ax', '<Plug>(textobj-comment-a)', { noremap = false })
        map('x', 'ix', '<Plug>(textobj-comment-i)', { noremap = false })
        map('o', 'ix', '<Plug>(textobj-comment-i)', { noremap = false })
      end,
    },
    { 'rhysd/vim-operator-surround', event = 'BufRead' },
    {
      'kana/vim-niceblock',
      event = 'BufRead',
      config = function()
        map('x', 'I', '<Plug>(niceblock-I)', { noremap = false })
        map('x', 'gI', '<Plug>(niceblock-gI)', { noremap = false })
        map('x', 'A', '<Plug>(niceblock-A)', { noremap = false })
      end,
    },
  }
  -- }}}

  -- Themes {{{
  use {
    { 'NTBBloodbath/doom-one.nvim' },
    { 'marko-cerovac/material.nvim' },
    { 'projekt0n/github-nvim-theme' },
  }
  -- }}}
end)
