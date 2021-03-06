-- Credits: https://github.com/rktjmp/highlight-current-n.nvim

local M = {}

local function highlight_current(buf, pos_row, pos_col)
  local query = vim.fn.getreg '/'
  local line = (vim.api.nvim_buf_get_lines(buf, (pos_row - 1), pos_row, false))[1]
  local matched_text = vim.fn.matchstr(line, query)
  local opts = {
    end_col = (pos_col + #matched_text),
    end_line = (pos_row - 1),
    virt_text = { { matched_text, 'IncSearch' } },
    virt_text_pos = 'overlay',
  }
  local ns_id = vim.api.nvim_create_namespace ''
  vim.api.nvim_buf_set_extmark(buf, ns_id, (pos_row - 1), pos_col, opts)
  local clear_cmd = string.format(
    ':lua if vim.fn.bufexists(%d) == 1 then vim.api.nvim_buf_clear_namespace(%d, %d, 0, -1) end',
    buf,
    buf,
    ns_id
  )
  local cmds = {
    'augroup HighlightCurrentN',
    ('autocmd CursorMoved * ++once ' .. clear_cmd),
    ('autocmd InsertEnter * ++once ' .. clear_cmd),
    ('autocmd CmdlineEnter * ++once ' .. clear_cmd),
    'augroup END',
  }
  return vim.cmd(table.concat(cmds, '\n'))
end

M.feedkey = function(key)
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local before_err = vim.v.errmsg
  vim.api.nvim_feedkeys(key, 'ni', false)
  local function _1_()
    if before_err == vim.v.errmsg then
      local _local_2_ = vim.api.nvim_win_get_cursor(win)
      local row = _local_2_[1]
      local col = _local_2_[2]
      return highlight_current(buf, row, col)
    end
  end
  return vim.schedule(_1_)
end

M.searched = function()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local _local_4_ = vim.api.nvim_win_get_cursor(win)
  local before_row = _local_4_[1]
  local before_col = _local_4_[2]
  local function _5_()
    local _local_6_ = vim.api.nvim_win_get_cursor(win)
    local after_row = _local_6_[1]
    local after_col = _local_6_[2]
    if (before_row ~= after_row) or (before_col ~= after_col) then
      return highlight_current(buf, after_row, after_col)
    end
  end
  return vim.schedule(_5_)
end

return M
