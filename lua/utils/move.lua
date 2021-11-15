-- Credit: https://github.com/fedepujol/move.nvim
local M = {}

local get_target = function(sRow, eRow)
  return vim.api.nvim_buf_get_lines(0, sRow, eRow, true)
end

local move_range = function(block, sRow, eRow)
  vim.api.nvim_buf_set_lines(0, sRow, eRow, true, block)
end

local reselect_block = function(dir, vSRow, vERow)
  vim.api.nvim_exec(':normal! \\e\\e', false)
  vim.api.nvim_exec(
    ':normal! ' .. (dir > 0 and vSRow + 2 or vSRow) .. 'ggV' .. (vERow + dir) .. 'gg',
    false
  )
end

local swap_line = function(source, target)
  local current_line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local lSource = ''
  local lTarget = ''

  if source == nil and target == nil then
    error 'Invalid lines'
  elseif source == nil and target ~= nil then
    source = current_line
  elseif source ~= nil and target == nil then
    error 'Invalid target line'
  end

  lSource = vim.api.nvim_buf_get_lines(0, source - 1, source, true)
  lTarget = vim.api.nvim_buf_get_lines(0, target - 1, target, true)

  vim.api.nvim_buf_set_lines(0, source - 1, source, true, lTarget)
  vim.api.nvim_buf_set_lines(0, target - 1, target, true, lSource)

  -- Set cursor position
  vim.api.nvim_win_set_cursor(0, { target, col })
end

M.horzChar = function(dir)
  -- sRow and col: current cursor position
  local sRow, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local target = ''
  local prefix = ''
  local suffix = ''
  local result = {}

  if dir < 0 and col < 1 then
    return
  end

  local selected = string.sub(line, col + 1, col + 1)
  if col == line:len() - 1 and dir > 0 then
    target = ' '
  else
    target = string.sub(line, col + 1 + dir, col + 1 + dir)
  end

  prefix = string.sub(line, 1, col + (dir > 0 and 0 or -1))
  suffix = string.sub(line, col + (dir > 0 and 3 or 2))
  table.insert(result, prefix .. (dir > 0 and target .. selected or selected .. target) .. suffix)
  vim.api.nvim_buf_set_lines(0, sRow - 1, sRow, true, result)
  vim.api.nvim_win_set_cursor(0, { sRow, col + dir })
end

M.horzBlock = function(dir)
  local sCol = vim.fn.col "'<"
  local eCol = vim.fn.col "'>"

  local sRow, col = unpack(vim.api.nvim_win_get_cursor(0))
  local eRow = vim.fn.line "'>"

  local lines = vim.api.nvim_buf_get_lines(0, sRow - 1, eRow, true)
  local results = {}

  for _, v in ipairs(lines) do
    local target = ''

    if dir > 0 then
      if eCol == v:len() then
        target = ' '
      else
        target = string.sub(v, eCol + 1, eCol + 1)
      end

      local selected = string.sub(v, sCol, eCol)
      local prefix = string.sub(v, 1, sCol - 1)
      local suffix = string.sub(v, eCol + 2)

      table.insert(
        results,
        prefix .. (dir > 0 and target .. selected or selected .. target) .. suffix
      )
    else
      if col == 0 then
        return
      end

      target = string.sub(v, sCol - 1, sCol - 1)
      if target == ' ' and string.sub(v, sCol - 2, sCol - 2) == ' ' then
        target = ''
      end

      local selected = string.sub(v, sCol, eCol)
      local prefix = string.sub(v, 1, sCol - 2)
      local suffix = string.sub(v, eCol + 1)

      table.insert(
        results,
        prefix .. (dir > 0 and target .. selected or selected .. target) .. suffix
      )
    end
  end

  vim.api.nvim_buf_set_lines(0, sRow - 1, eRow, true, results)
  vim.api.nvim_win_set_cursor(0, { sRow, (sCol - 1) + dir })

  vim.cmd 'execute "normal! \\e\\e"'
  local suffix = (eCol - sCol > 0 and (eCol - sCol) .. 'l' or '')
  suffix = suffix .. (eRow - sRow > 0 and (eRow - sRow) .. 'j' or '')
  vim.cmd('execute "normal! \\<C-V>' .. suffix .. '"')
end

M.verticalLine = function(dir)
  -- Get the last line of current buffer
  local last_line = vim.fn.line '$'

  -- Get current cursor position
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local line = cursor_position[1]

  if dir == nil then
    error('Missing offset', 3)
  end

  -- Edges
  if line == 1 and dir < 0 then
    return
  end
  if line == last_line and dir > 0 then
    return
  end

  -- General Case
  if line >= 1 and line <= last_line then
    swap_line(line, line + dir)
  end
end

M.verticalBlock = function(dir, line1, line2)
  local vSRow = line1 or vim.fn.line 'v'
  local vERow = line2 or vim.api.nvim_win_get_cursor(0)[1]
  local last_line = vim.fn.line '$'

  -- Zero-based and end exclusive
  vSRow = vSRow - 1

  if vSRow > vERow then
    local aux = vSRow
    vSRow = vERow
    vERow = aux
  end

  -- Edges
  if vSRow == 0 and dir < 0 then
    vim.api.nvim_exec(':normal! ' .. vSRow .. 'ggV' .. vERow .. 'gg', false)
    return
  end
  if vERow == last_line and dir > 0 then
    vim.api.nvim_exec(':normal! ' .. (vSRow + 1) .. 'ggV' .. (vERow + dir) .. 'gg', false)
    return
  end

  local vBlock = vim.api.nvim_buf_get_lines(0, vSRow, vERow, true)

  if dir < 0 then
    local vTarget = get_target(vSRow - 1, vSRow)
    table.insert(vBlock, vTarget[1])
  elseif dir > 0 then
    local vTarget = get_target(vERow, vERow + 1)
    table.insert(vBlock, 1, vTarget[1])
  end

  move_range(vBlock, (dir > 0 and vSRow or vSRow - 1), (dir > 0 and vERow + 1 or vERow))
  reselect_block(dir, vSRow, vERow)
end

return M
