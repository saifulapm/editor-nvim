local fastaction = require 'lsp-fastaction'
fastaction.setup {
  action_data = {
    dart = {
      { pattern = 'import library', key = 'i', order = 1 },
      { pattern = 'wrap with widget', key = 'w', order = 2 },
      { pattern = 'column', key = 'c', order = 3 },
      { pattern = 'row', key = 'r', order = 3 },
      { pattern = 'container', key = 'C', order = 4 },
      { pattern = 'center', key = 'E', order = 4 },
      { pattern = 'padding', key = 'p', order = 4 },
      { pattern = 'remove', key = 'r', order = 5 },
      -- range code action
      { pattern = "surround with %'if'", key = 'i', order = 2 },
      { pattern = 'try%-catch', key = 't', order = 2 },
      { pattern = 'for%-in', key = 'f', order = 2 },
      { pattern = 'setstate', key = 's', order = 2 },
    },
  },
}
global.map('n', '<leader>ca', "<esc><Cmd>lua require('lsp-fastaction').code_action()<CR>")
global.map('x', '<leader>ca', "<esc><Cmd>lua require('lsp-fastaction').range_code_action()<CR>")

