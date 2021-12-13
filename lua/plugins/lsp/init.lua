local lsp = vim.lsp

local function lspSymbol(name, icon)
  vim.fn.sign_define('DiagnosticSign' .. name, { text = icon, numhl = 'DiagnosticDefault' .. name })
end

lspSymbol('Error', '✗')
lspSymbol('Info', '')
lspSymbol('Hint', '')
lspSymbol('Warn', '')

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = '',
    spacing = 0,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

local popup_opts = { border = 'single', focusable = false }

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, popup_opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true, buffer = bufnr }
  local map = global.map

  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gI', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  map('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map(
    'n',
    '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts
  )
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('n', 'ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map('n', '[d', function()
    vim.diagnostic.goto_prev {
      popup_opts = { border = 'rounded', focusable = false, source = 'always' },
    }
  end, opts)
  map('n', ']d', function()
    vim.diagnostic.goto_next {
      popup_opts = { border = 'rounded', focusable = false, source = 'always' },
    }
  end, opts)
  map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  if client.resolved_capabilities.implementation then
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  end

  if client.resolved_capabilities.type_definition then
    map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  end

  map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('x', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

  if client.supports_method 'textDocument/rename' then
    map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
  end

  require('illuminate').on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, server in ipairs {
  'intelephense',
  'shopify',
  'eslint',
  'jsonls',
  'null_ls',
  'sumneko',
  'tsserver',
  'dart',
  'bashls',
  'denols',
} do
  require('plugins.lsp.' .. server).setup(on_attach, capabilities)
end

-- suppress lspconfig messages
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match '%[lspconfig%]' then
    return
  end

  notify(msg, ...)
end
