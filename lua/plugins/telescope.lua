local telescope = require 'telescope'
local actions = require 'telescope.actions'
local action_set = require 'telescope.actions.set'
local map = global.map

---@param opts table
---@return table
local function dropdown(opts)
  return require('telescope.themes').get_dropdown(vim.tbl_deep_extend('force', opts or {}, {
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
  }))
end

telescope.setup {
  defaults = {
    set_env = { ['TERM'] = vim.env.TERM },
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    prompt_prefix = ' ',
    selection_caret = '» ',
    mappings = {
      i = {
        ['<C-w>'] = actions.send_selected_to_qflist,
        ['<c-c>'] = function()
          vim.cmd 'stopinsert!'
        end,
        ['<esc>'] = actions.close,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-j>'] = actions.cycle_history_next,
        ['<c-k>'] = actions.cycle_history_prev,
      },
      n = {
        ['<C-w>'] = actions.send_selected_to_qflist,
      },
    },
    file_ignore_patterns = { '%.jpg', '%.jpeg', '%.png', '%.otf', '%.ttf' },
    path_display = { 'smart', 'absolute', 'truncate' },
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        preview_width = 0.45,
      },
    },
    winblend = 3,
    history = {
      path = vim.fn.stdpath 'data' .. '/telescope_history.sqlite3',
    },
  },
  extensions = {
    frecency = {
      workspaces = {
        conf = vim.env.DOTFILES,
        project = vim.env.PROJECTS_DIR,
        wiki = vim.g.wiki_path,
      },
    },
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    },
  },
  pickers = {
    buffers = dropdown {
      sort_mru = true,
      sort_lastused = true,
      show_all_buffers = true,
      ignore_current_buffer = true,
      previewer = false,
      theme = 'dropdown',
      mappings = {
        i = { ['<c-x>'] = 'delete_buffer' },
        n = { ['<c-x>'] = 'delete_buffer' },
      },
    },
    oldfiles = dropdown(),
    live_grep = {
      file_ignore_patterns = { '.git/' },
    },
    current_buffer_fuzzy_find = dropdown {
      previewer = false,
      shorten_path = false,
    },
    lsp_code_actions = {
      theme = 'cursor',
    },
    colorscheme = {
      enable_preview = true,
    },
    find_files = {
      hidden = true,
      attach_mappings = function(_)
        action_set.select:enhance {
          post = function()
            vim.cmd ':normal! zx'
          end,
        }
        return true
      end,
    },
    git_branches = dropdown(),
    git_bcommits = {
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
    },
    git_commits = {
      layout_config = {
        horizontal = {
          preview_width = 0.55,
        },
      },
    },
    reloader = dropdown(),
  },
}

--- NOTE: this must be required after setting up telescope
--- otherwise the result will be cached without the updates
--- from the setup call
local builtins = require 'telescope.builtin'

local function project_files(opts)
  if not pcall(builtins.git_files, opts) then
    builtins.find_files(opts)
  end
end

local function nvim_config()
  builtins.find_files {
    prompt_title = '~ nvim config ~',
    cwd = vim.fn.stdpath 'config',
    file_ignore_patterns = { '.git/.*', 'dotbot/.*' },
  }
end

local function dotfiles()
  builtins.find_files {
    prompt_title = '~ dotfiles ~',
    cwd = vim.g.dotfiles,
  }
end

local function orgfiles()
  builtins.find_files {
    prompt_title = 'Org',
    cwd = vim.fn.expand '~/Dropbox/org/',
  }
end

local function norgfiles()
  builtins.find_files {
    prompt_title = 'Norg',
    cwd = vim.fn.expand '~/Dropbox/neorg/',
  }
end

local function frecency()
  telescope.extensions.frecency.frecency(dropdown {
    -- NOTE: remove default text as it's slow
    -- default_text = ':CWD:',
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

local function gh_notifications()
  telescope.extensions.ghn.ghn(dropdown())
end

local function installed_plugins()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath 'data' .. '/site/pack/packer',
  }
end

local function tmux_sessions()
  telescope.extensions.tmux.sessions {}
end

local function tmux_windows()
  telescope.extensions.tmux.windows {
    entry_format = '#S: #T',
  }
end

map('n', '<c-p>', project_files)
map('n', '<leader>fa', builtins.builtin)
map('n', '<leader>fb', builtins.current_buffer_fuzzy_find)
map('n', '<leader>fd', dotfiles)
map('n', '<leader>ff', builtins.find_files)
map('n', '<leader>fn', gh_notifications)
map('n', '<leader>fgc', builtins.git_commits)
map('n', '<leader>fgb', builtins.git_branches)
map('n', '<leader>fm', builtins.man_pages)
map('n', '<leader>fh', frecency)
map('n', '<leader>fc', nvim_config)
map('n', '<leader>fo', builtins.buffers)
map('n', '<leader>fp', installed_plugins)
map('n', '<leader>fO', orgfiles)
map('n', '<leader>fN', norgfiles)
map('n', '<leader>fR', builtins.reloader)
map('n', '<leader>fr', builtins.resume)
map('n', '<leader>fs', builtins.live_grep)
map('n', '<leader>fts', tmux_sessions)
map('n', '<leader>ftw', tmux_windows)
map('n', '<leader>f?', builtins.help_tags)
map('n', '<leader>fcd', builtins.lsp_workspace_diagnostics)
map('n', '<leader>fcs', builtins.lsp_document_symbols)
map('n', '<leader>fcw', builtins.lsp_dynamic_workspace_symbols)
