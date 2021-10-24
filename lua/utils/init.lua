local M = {}

-- Toggle (,) and (;) easily
M.toggle_char = function(char)
  local fn = vim.fn
  local line = fn.getline '.'
  local newline = ''

  if char == string.sub(line, #line) then
    newline = line:sub(1, -2)
  else
    newline = line .. char
  end

  return fn.setline('.', newline)
end

-- load plugin after entering vim ui
M.lazy = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require('packer').loader(plugin)
    end, timer)
  end
end

M.buf_only = function()
  local del_non_modifiable = vim.g.bufonly_delete_non_modifiable or false

  local cur = vim.api.nvim_get_current_buf()

  local deleted, modified = 0, 0

  for _, n in ipairs(vim.api.nvim_list_bufs()) do
    -- If the iter buffer is modified one, then don't do anything
    if vim.api.nvim_buf_get_option(n, 'modified') then
      modified = modified + 1

      -- iter is not equal to current buffer
      -- iter is modifiable or del_non_modifiable == true
      -- `modifiable` check is needed as it will prevent closing file tree ie. NERD_tree
    elseif n ~= cur and (vim.api.nvim_buf_get_option(n, 'modifiable') or del_non_modifiable) then
      vim.api.nvim_buf_delete(n, {})
      deleted = deleted + 1
    end
  end

  print('BufOnly: ' .. deleted .. ' deleted buffer(s), ' .. modified .. ' modified buffer(s)')
end

M.close_buffer = function(_, force)
  -- Options
  local opts = {
    next = 'cycle', -- how to retrieve the next buffer
    quit = false, -- exit when last buffer is deleted
    --TODO make this a chadrc flag/option
  }

  -- Switch to buffer 'buf' on each window from list 'windows'
  local function switch_buffer(windows, buf)
    local cur_win = vim.fn.winnr()
    for _, winid in ipairs(windows) do
      vim.cmd(string.format('%d wincmd w', vim.fn.win_id2win(winid)))
      vim.cmd(string.format('buffer %d', buf))
    end
    vim.cmd(string.format('%d wincmd w', cur_win)) -- return to original window
  end

  -- Select the first buffer with a number greater than given buffer
  local function get_next_buf(buf)
    local next = vim.fn.bufnr '#'
    if opts.next == 'alternate' and vim.fn.buflisted(next) == 1 then
      return next
    end
    for i = 0, vim.fn.bufnr '$' - 1 do
      next = (buf + i) % vim.fn.bufnr '$' + 1 -- will loop back to 1
      if vim.fn.buflisted(next) == 1 then
        return next
      end
    end
  end

  local buf = vim.fn.bufnr()
  if vim.fn.buflisted(buf) == 0 then -- exit if buffer number is invalid
    vim.cmd 'close'
    return
  end

  if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
    if opts.quit then
      -- exit when there is only one buffer left
      if force then
        vim.cmd 'qall!'
      else
        vim.cmd 'confirm qall'
      end
      return
    end

    local term, _ = pcall(function()
      return vim.api.nvim_buf_get_var(buf, 'term_type')
    end)

    if term then
      -- Must be a window type
      vim.cmd(string.format('setlocal nobl', buf))
      vim.cmd 'enew'
      return
    end
    -- don't exit and create a new empty buffer
    vim.cmd 'enew'
    vim.cmd 'bp'
  end

  local next_buf = get_next_buf(buf)
  local windows = vim.fn.getbufinfo(buf)[1].windows

  -- force deletion of terminal buffers to avoid the prompt
  if force or vim.fn.getbufvar(buf, '&buftype') == 'terminal' then
    local term, type = pcall(function()
      return vim.api.nvim_buf_get_var(buf, 'term_type')
    end)

    -- TODO this scope is error prone, make resilient
    if term then
      if type == 'wind' then
        -- hide from bufferline
        vim.cmd(string.format('%d bufdo setlocal nobl', buf))
        -- swtich to another buff
        -- TODO switch to next bufffer, this works too
        vim.cmd 'BufferLineCycleNext'
      else
        local cur_win = vim.fn.winnr()
        -- we can close this window
        vim.cmd(string.format('%d wincmd c', cur_win))
        return
      end
    else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format('bd! %d', buf))
    end
  else
    switch_buffer(windows, next_buf)
    vim.cmd(string.format('silent! confirm bd %d', buf))
  end
  -- revert buffer switches if user has canceled deletion
  if vim.fn.buflisted(buf) == 1 then
    switch_buffer(windows, buf)
  end
end

return M
