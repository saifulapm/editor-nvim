local action = require('nvim-tree.config').nvim_tree_callback

vim.g.nvim_tree_icons = {
  default = '',
  git = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    untracked = '',
    deleted = '',
  },
}

vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_root_folder_modifier = ':t'
-- vim.g.nvim_tree_ignore = { '.DS_Store', 'fugitive:', '.git' }
vim.g.nvim_tree_highlight_opened_files = 1

global.map('n', '<c-n>', [[<cmd>NvimTreeToggle<CR>]])

require('nvim-tree').setup {
  view = {
    width = '20%',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = 'cd', cb = action 'cd' },
        { key = 'v', cb = action 'vsplit' },
        { key = 's', cb = action 'split' },
      },
    },
  },
  diagnostics = {
    enable = false,
    icons = {
      error = '✗',
      warning = '',
      info = '',
      hint = '',
    },
  },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  auto_close = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = false,
    custom = { '.DS_Store', 'fugitive:', '.git', '_compiled.lua' },
  },
}
