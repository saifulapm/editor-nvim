local gitsigns = require 'gitsigns'

gitsigns.setup {
  signs = {
    add = { hl = 'GitSignsAdd', text = '▌' },
    change = { hl = 'GitSignsChange', text = '▌' },
    delete = { hl = 'GitSignsDelete', text = '▌' },
    topdelete = { hl = 'GitSignsDelete', text = '▌' },
    changedelete = { hl = 'GitSignsChange', text = '▌' },
  },
  word_diff = false,
  numhl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,
    ['n [h'] = { expr = true, "&diff ? ']h' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
    ['n ]h'] = { expr = true, "&diff ? '[h' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
    ['n <localleader>gw'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <localleader>gre'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <localleader>gbl'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    ['n <localleader>gbd'] = '<cmd>lua require"gitsigns".toggle_word_diff()<CR>',
    ['n <leader>lm'] = '<cmd>lua require"gitsigns".setqflist("all")<CR>',
    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  },
}
