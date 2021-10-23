local fn = vim.fn
local api = vim.api
local fmt = string.format
local contains = vim.tbl_contains
local augroup = global.augroup

api.nvim_exec(
  [[
   augroup vimrc -- Ensure all autocommands are cleared
   autocmd!
   augroup END
  ]],
  ''
)

augroup('UpdateVim', {
  {
    events = 'BufWritePost',
    targets = { '~/.config/nvim/lua/*.lua', '$MYVIMRC' },
    modifiers = { '++nested' },
    command = function()
      local ok, msg = pcall(vim.cmd, 'source $MYVIMRC | redraw | silent doautocmd ColorScheme')
      msg = ok and 'sourced ' .. vim.fn.fnamemodify(vim.env.MYVIMRC, ':t') or msg
      vim.notify(msg)
    end,
  },
  {
    events = { 'FocusLost' },
    targets = { '*' },
    command = 'silent! wall',
  },
  -- Make windows equal size when vim resizes
  {
    events = { 'VimResized' },
    targets = { '*' },
    command = 'wincmd =',
  },
})
