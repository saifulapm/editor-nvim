local M = {}

M.init = function(theme)
  if not theme then
    theme = 'onedark'
  end

  -- set the global theme, used at various places like theme switcher, highlights
  vim.g.main_theme = theme

  local present, base16 = pcall(require, 'base16')

  if present then
    -- first load the base16 theme
    base16(base16.themes(theme), true)

    -- unload to force reload
    package.loaded['colors.highlights' or false] = nil
    -- then load the highlights
    require 'colors.highlights'
  else
    return false
  end
end

M.get = function(theme)
  if not theme then
    theme = vim.g.main_theme
  end
  return require('hl_themes.' .. theme)
end

return M
