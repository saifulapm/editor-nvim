vim.g.did_load_filetypes = 1
-- HACK: see https://github.com/wbthomason/packer.nvim/issues/180
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')
local has_impatient = vim.loop.fs_stat(vim.fn.stdpath('data') .. '/site/pack/packer/start/impatient.nvim')

if has_impatient then
  require 'impatient'
end

-- Global Modules
require 'core'
-- Loading Modules
R 'core.options'
R '_compiled'

-- Load keybindings module at the end because the keybindings module cost is high
vim.defer_fn(function()
  R 'core.mappings'
end, 20)
