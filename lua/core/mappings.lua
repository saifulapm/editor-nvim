local fn = vim.fn
local api = vim.api
local command = global.command
local fmt = string.format
local map = global.map

-- Basic Mapping
map("n", "\\", ",")
map("n", "<Esc>", ":nohl<CR>")
map({"n", "x", "o"}, "<Tab>", "%", { noremap = false })
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "L", "$")
map('n', "<CR>", ":", { silent = false })
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- Insert Mode Mapping
map("i", "<C-p>", "<Esc>pa")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")
map("i", "<C-k>", "<Esc>O")
map("i", "<C-j>", "<Esc>o")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-l>", "<End>")
map("i", "<C-w>", "<C-[>diwa")
map("i", "<C-h>", "<BS>")
map("i", "<C-d>", "<Del>")
map("i", "<C-u>", "<C-G>u<C-U>")
map("i", "<C-s>", "<Esc>:w<CR>")
map("i", "<C-q>", "<Esc>:wq<CR>")

-- Commandline Mapping
map("c", "<C-b>", "<Left>")
map("c", "<C-f>", "<Right>")
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-d>", "<Del>")
map("c", "<C-h>", "<BS>")
map("c", "<C-t>", [[<C-R>=expand("%:p:h") . "/" <CR>]])

-- MACROS
vim.cmd [[
function! ExecuteMacroOverVisualRange()
echo "@".getcmdline()
execute ":'<,'>normal @".nr2char(getchar())
endfunction
]]

map('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>', { silent = false })

-- Buffer
map('n', '<leader>on', ':lua require("utils").buf_only()')
map("n", "<Leader><Leader>", "<C-^>")
map('n', '<leader>x', ':lua require("utils").close_buffer()')

-- Windows
-- Change two horizontally split windows to vertical splits
map('n', '<localleader>wh', '<C-W>t <C-W>K')
-- Change two vertically split windows to horizontal splits
map('n', '<localleader>wv', '<C-W>t <C-W>H')
-- equivalent to gf but opens the window in a vertical split
-- vim doesn't have a native mapping for this as <C-w>f normally
-- opens a horizontal split
map('n', '<C-w>f', '<C-w>vgf')
map('n', '<leader>qw', '<cmd>bd!<CR>')

map('n', 'Y', 'y$')
map('v', '<', '<gv')
map('v', '>', '>gv')
-- visually select the block of text I just pasted in Vim
map('n', 'gV', '`[v`]')
--Remap back tick for jumping to marks more quickly back
map('n', "'", '`')

-- Quick find/replace
map('n', '<leader>[', [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]], { silent = false })
map('n', '<leader>]', [[:s/\<<C-r>=expand("<cword>")<CR>\>/]], { silent = false })
map('v', '<leader>[', [["zy:%s/<C-r><C-o>"/]], { silent = false })

--open a new file in the same directory
map('n', '<leader>nf', [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })
--open a new file in the same directory
map('n', '<leader>ns', [[:vsp <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })

-- Quickfix
map('n', ']q', '<cmd>cnext<CR>zz')
map('n', '[q', '<cmd>cprev<CR>zz')
map('n', ']l', '<cmd>lnext<cr>zz')
map('n', '[l', '<cmd>lprev<cr>zz')

-- ?ie | entire object
map('x', 'ie', [[gg0oG$]])
map('o', 'ie', [[<cmd>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>]])

-- Zero should go to the first non-blank character
map({'n','x','o'}, '0', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true })
-- when going to the end of the line in visual mode ignore whitespace characters
map('v', '$', 'g_')

-- Toggle top/center/bottom
map(
  'n',
  'zz',
  [[(winline() == (winheight (0) + 1)/ 2) ?  'zt' : (winline() == 1)? 'zb' : 'zz']],
  { expr = true }
)

-- This line opens my plugins file in a vertical split
map('n', '<leader>ep', fmt('<Cmd>vsplit %s/lua/plugins/init.lua<CR>', fn.stdpath 'config'))

-- Quotes
map('n', [[<leader>"]], [[ciw"<c-r>""<esc>]])
map('n', '<leader>`', [[ciw`<c-r>"`<esc>]])
map('n', "<leader>'", [[ciw'<c-r>"'<esc>]])
map('n', '<leader>)', [[ciw(<c-r>")<esc>]])
map('n', '<leader>}', [[ciw{<c-r>"}<esc>]])

-- Map Q to replay q register
map('n', 'Q', '@q')

-- Multiple Cursor Replacement
map({'n', 'v'}, 'cn', '*``cgn')
map({'n', 'v'}, 'cN', '*``cgN')

map('c', 'w!!', [[w !sudo tee % >/dev/null]])

-- Grep Operator
function global.grep_operator(type)
  local saved_unnamed_register = vim.fn.getreg '@@'
  if type:match 'v' then
    vim.cmd [[normal! `<v`>y]]
  elseif type:match 'char' then
    vim.cmd [[normal! `[v`]y']]
  else
    return
  end
  -- Use Winnr to check if the cursor has moved it if has restore it
  local winnr = vim.fn.winnr()
  vim.cmd [[silent execute 'grep! ' . shellescape(@@) . ' .']]
  vim.fn.setreg('@@', saved_unnamed_register)
  if vim.fn.winnr() ~= winnr then
    vim.cmd [[wincmd p]]
  end
end

-- http://travisjeffery.com/b/2011/10/m-x-occur-for-vim/
map('n', '<leader>g', [[:silent! set operatorfunc=v:lua.global.grep_operator<cr>g@]])
map('x', '<leader>g', [[:call v:lua.global.grep_operator(visualmode())<cr>]])

-- Toggle list
local is_vim_list_open = function ()
  for _, win in ipairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    local location_list = fn.getloclist(0, { filewinid = 0 })
    local is_loc_list = location_list.filewinid > 0
    if vim.bo[buf].filetype == 'qf' or is_loc_list then
      return true
    end
  end
  return false
end

function global.toggle_list(list_type)
  local is_location_target = list_type == 'location'
  local prefix = is_location_target and 'l' or 'c'
  local L = vim.log.levels
  local is_open = is_vim_list_open()
  if is_open then
    return fn.execute(prefix .. 'close')
  end
  local list = is_location_target and fn.getloclist(0) or fn.getqflist()
  if vim.tbl_isempty(list) then
    local msg_prefix = (is_location_target and 'Location' or 'QuickFix')
    return vim.notify(msg_prefix .. ' List is Empty.', L.WARN)
  end

  local winnr = fn.winnr()
  fn.execute(prefix .. 'open')
  if fn.winnr() ~= winnr then
    vim.cmd 'wincmd p'
  end
end
map('n', '<leader>ls', function()
  global.toggle_list 'c'
end)
map('n', '<leader>li', function()
  global.toggle_list 'l'
end)

command { 'Todo', [[noautocmd silent! grep! 'TODO:\|FIXME:\|BUG:\|HACK:' | copen]] }

-- Plugins Mapping
-- Add Packer commands because we are not loading it at startup
vim.cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
vim.cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"

-- Terminal Mappings
global.augroup('AddTerminalMappings', {
  {
    events = { 'TermOpen' },
    targets = { 'term://*' },
    command = function()
      if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
        local opts = { silent = false, buffer = 0 }
        map('t', '<esc>', [[<C-\><C-n>]], opts)
        map('t', 'jk', [[<C-\><C-n>]], opts)
        map('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        map('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        map('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        map('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
        map('t', ']t', [[<C-\><C-n>:tablast<CR>]])
        map('t', '[t', [[<C-\><C-n>:tabnext<CR>]])
        map('t', '<S-Tab>', [[<C-\><C-n>:bprev<CR>]])
        map('t', '<leader><Tab>', [[<C-\><C-n>:close \| :bnext<cr>]])
      end
    end,
  },
})

command {
  'ToggleBackground',
  function()
    vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
  end,
}

command {
  'ReloadModule',
  function(args)
    require('plenary.reload').reload_module(args)
  end,
  nargs = 1,
}
