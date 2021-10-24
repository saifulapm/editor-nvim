local M = {}

M.get = function()
  if not vim.g.colors_name then
    theme = 'default'
  else
    theme = vim.g.colors_name
  end

  return require('colors.' .. theme)
end

return M
