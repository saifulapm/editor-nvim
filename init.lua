vim.g.did_load_filetypes = 1
-- HACK: see https://github.com/wbthomason/packer.nvim/issues/180

vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')
local has_impatient = vim.loop.fs_stat(
  vim.fn.stdpath 'data' .. '/site/pack/packer/start/impatient.nvim'
)
local has_compiled = vim.loop.fs_stat(vim.fn.stdpath 'config' .. '/lua/_compiled.lua')

if has_impatient then
  require 'impatient'
end

-- Global Modules
require 'core'
-- Loading Modules
R 'core.options'

if has_compiled then
  R '_compiled'
end

-- Load keybindings module at the end because the keybindings module cost is high
vim.defer_fn(function()
  R 'core.mappings'
end, 20)
