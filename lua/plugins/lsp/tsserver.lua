local lspconfig = require 'lspconfig'

local ts_utils_settings = {
  -- debug = true,
  import_all_scan_buffers = 100,
  eslint_bin = 'eslint_d',
  eslint_enable_diagnostics = true,
  eslint_opts = {
    condition = function(utils)
      return utils.root_has_file '.eslintrc.js'
    end,
    diagnostics_format = '#{m} [#{c}]',
  },
  enable_formatting = true,
  formatter = 'eslint_d',
  update_imports_on_move = true,
  -- filter out dumb module warning
  filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function(on_attach, capabilities)
  lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      on_attach(client, bufnr)

      local ts_utils = require 'nvim-lsp-ts-utils'
      ts_utils.setup(ts_utils_settings)
      ts_utils.setup_client(client)

      global.map('n', 'gs', ':TSLspOrganize<CR>', { buffer = bufnr })
      global.map('n', 'gI', ':TSLspRenameFile<CR>', { buffer = bufnr })
      global.map('n', 'go', ':TSLspImportAll<CR>', { buffer = bufnr })
      global.map('n', 'qq', ':TSLspFixCurrent<CR>', { buffer = bufnr })
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }
end

return M
