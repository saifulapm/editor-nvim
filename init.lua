-- Global Modules
require('core')
-- Loading Modules
R('core.options')

-- Load keybindings module at the end because the keybindings module cost is high
vim.defer_fn(function()
  R('core.mappings')
end, 20)
