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

augroup('DisableComment', {
  {
    events = 'FileType',
    targets = { '*' },
    command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
  },
})

augroup('UpdateVim', {
  -- {
  --   events = 'BufWritePost',
  --   targets = {
  --     '~/.config/nvim/lua/core/*.lua',
  --     '~/.config/nvim/lua/colors/*.lua',
  --     '~/.config/nvim/lua/utils/*.lua',
  --     '$MYVIMRC',
  --   },
  --   modifiers = { '++nested' },
  --   command = function()
  --     vim.cmd 'source $MYVIMRC | redraw | silent doautocmd ColorScheme'
  --   end,
  -- },
  -- {
  --   events = 'BufWritePost',
  --   targets = { '~/.config/nvim/lua/plugins/*.lua' },
  --   modifiers = { '++nested' },
  --   command = function()
  --     require 'plugins'
  --     require('packer').compile()
  --     vim.cmd 'source $MYVIMRC | redraw | silent doautocmd ColorScheme'
  --   end,
  -- },
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

augroup('ClearSearchHL', {
  {
    -- automatically clear search highlight once leaving the commandline
    events = { 'CmdlineEnter' },
    targets = { '[/\\?]' },
    command = ':set hlsearch',
  },
  {
    events = { 'CmdlineLeave' },
    targets = { '[/\\?]' },
    command = function()
      vim.cmd 'set nohlsearch'
      require('utils.hlsearch').searched()
    end,
  },
})

local smart_close_filetypes = {
  'help',
  'git-status',
  'git-log',
  'gitcommit',
  'dbui',
  'fugitive',
  'fugitiveblame',
  'LuaTree',
  'log',
  'tsplayground',
  'qf',
}

local function smart_close()
  if fn.winnr '$' ~= 1 then
    api.nvim_win_close(0, true)
  end
end

augroup('SmartClose', {
  {
    -- Auto open grep quickfix window
    events = { 'QuickFixCmdPost' },
    targets = { '*grep*' },
    command = 'cwindow',
  },
  {
    -- Close certain filetypes by pressing q.
    events = { 'FileType' },
    targets = { '*' },
    command = function()
      local is_readonly = (vim.bo.readonly or not vim.bo.modifiable) and fn.hasmapto('q', 'n') == 0

      local is_eligible = vim.bo.buftype ~= ''
        or is_readonly
        or vim.wo.previewwindow
        or contains(smart_close_filetypes, vim.bo.filetype)

      if is_eligible then
        global.map('n', 'q', smart_close, { buffer = 0, nowait = true })
      end
    end,
  },
  {
    -- Close quick fix window if the file containing it was closed
    events = { 'BufEnter' },
    targets = { '*' },
    command = function()
      if fn.winnr '$' == 1 and vim.bo.buftype == 'quickfix' then
        api.nvim_buf_delete(0, { force = true })
      end
    end,
  },
  {
    -- automatically close corresponding loclist when quitting a window
    events = { 'QuitPre' },
    targets = { '*' },
    modifiers = { 'nested' },
    command = function()
      if vim.bo.filetype ~= 'qf' then
        vim.cmd 'silent! lclose'
      end
    end,
  },
})

augroup('CheckOutsideTime', {
  {
    -- automatically check for changed files outside vim
    events = { 'WinEnter', 'BufWinEnter', 'BufWinLeave', 'BufRead', 'BufEnter', 'FocusGained' },
    targets = { '*' },
    command = 'silent! checktime',
  },
})

-- augroup('Templates', {
--   {
--     events = { 'BufNewFile' },
--     targets = { '*.sh' },
--     command = '0r $DOTFILES/.config/nvim/templates/skeleton.sh',
--   },
--   {
--     events = { 'BufNewFile' },
--     targets = { '*.lua' },
--     command = '0r $DOTFILES/.config/nvim/templates/skeleton.lua',
--   },
-- })

local function clear_commandline()
  --- Track the timer object and stop any previous timers before setting
  --- a new one so that each change waits for 10secs and that 10secs is
  --- deferred each time
  local timer
  return function()
    if timer then
      timer:stop()
    end
    timer = vim.defer_fn(function()
      if fn.mode() == 'n' then
        vim.cmd [[echon '']]
      end
    end, 10000)
  end
end

augroup('ClearCommandMessages', {
  {
    events = { 'CmdlineLeave', 'CmdlineChanged' },
    targets = { ':' },
    command = clear_commandline(),
  },
})

augroup('TextYankHighlight', {
  {
    -- don't execute silently in case of errors
    events = { 'TextYankPost' },
    targets = { '*' },
    command = function()
      vim.highlight.on_yank {
        timeout = 500,
        on_visual = false,
        higroup = 'Visual',
      }
    end,
  },
})

augroup('WindowBehaviours', {
  {
    -- map q to close command window on quit
    events = { 'CmdwinEnter' },
    targets = { '*' },
    command = 'nnoremap <silent><buffer><nowait> q <C-W>c',
  },
  -- Automatically jump into the quickfix window on open
  {
    events = { 'QuickFixCmdPost' },
    targets = { '[^l]*' },
    modifiers = { 'nested' },
    command = 'cwindow',
  },
  {
    events = { 'QuickFixCmdPost' },
    targets = { 'l*' },
    modifiers = { 'nested' },
    command = 'lwindow',
  },
})

local empty = function(item)
  if not item then
    return true
  end
  local item_type = type(item)
  if item_type == 'string' then
    return item == ''
  elseif item_type == 'table' then
    return vim.tbl_isempty(item)
  end
end

local save_excluded = { 'lua.luapad', 'gitcommit', 'NeogitCommitMessage' }
local function can_save()
  return empty(vim.bo.buftype)
    and not empty(vim.bo.filetype)
    and vim.bo.modifiable
    and not vim.tbl_contains(save_excluded, vim.bo.filetype)
end

augroup('Utilities', {
  {
    -- @source: https://vim.fandom.com/wiki/Use_gf_to_open_a_file_via_its_URL
    events = { 'BufReadCmd' },
    targets = { 'file:///*' },
    command = function()
      vim.cmd(fmt('bd!|edit %s', vim.uri_from_fname '<afile>'))
    end,
  },
  -- BUG: this causes the cursor to jump to the top on VimEnter
  {
    -- When editing a file, always jump to the last known cursor position.
    -- Don't do it for commit messages, when the position is invalid, or when
    -- inside an event handler (happens when dropping a file on gvim).
    events = { 'BufWinEnter' },
    targets = { '*' },
    command = function()
      local pos = fn.line [['"]]
      if
        vim.bo.ft ~= 'gitcommit'
        and vim.fn.win_gettype() ~= 'popup'
        and pos > 0
        and pos <= fn.line '$'
      then
        vim.cmd 'keepjumps normal g`"'
      end
    end,
  },
  {
    events = { 'FileType' },
    targets = { 'gitcommit', 'gitrebase' },
    command = 'set bufhidden=delete',
  },
  {
    events = { 'BufWritePre', 'FileWritePre' },
    targets = { '*' },
    command = "silent! call mkdir(expand('<afile>:p:h'), 'p')",
  },
  {
    events = { 'BufLeave' },
    targets = { '*' },
    command = function()
      if can_save() then
        vim.cmd 'silent! update'
      end
    end,
  },
  {
    events = { 'BufWritePost' },
    targets = { '*' },
    modifiers = { 'nested' },
    command = function()
      if empty(vim.bo.filetype) or fn.exists 'b:ftdetect' == 1 then
        vim.cmd [[
            unlet! b:ftdetect
            filetype detect
            echom 'Filetype set to ' . &ft
          ]]
      end
    end,
  },
  {
    events = { 'Syntax' },
    targets = { '*' },
    command = "if 5000 < line('$') | syntax sync minlines=200 | endif",
  },
})
