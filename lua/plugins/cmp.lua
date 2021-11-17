---@diagnostic disable: undefined-field
local api = vim.api
local cmp = require 'cmp'
local kinds = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = 'ﰠ',
  Variable = '',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '塞',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local t = function(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

local function feed(key, mode)
  api.nvim_feedkeys(t(key), mode or '', true)
end

local function get_luasnip()
  local ok, luasnip = pcall(require, 'luasnip')
  if not ok then
    return nil
  end
  return luasnip
end

local function tab(fallback)
  local luasnip = get_luasnip()
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip and luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif api.nvim_get_mode().mode == 'c' then
    fallback()
  else
    feed '<Plug>(Tabout)'
  end
end

local function shift_tab(fallback)
  local luasnip = get_luasnip()
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip and luasnip.jumpable(-1) then
    luasnip.jump(-1)
  elseif api.nvim_get_mode().mode == 'c' then
    fallback()
  else
    feed '<Plug>(TaboutBack)'
  end
end

cmp.setup {
  completion = {
    keyword_length = 2, -- avoid keyword completion
  },
  experimental = {
    ghost_text = false,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(tab, { 'i', 'c' }),
    ['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.config.disable,
    ['<C-space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  formatting = {
    deprecated = true,
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = kinds[vim_item.kind]
      local name = entry.source.name
      local completion = entry.completion_item.data
      -- FIXME: automate this using a regex to normalise names
      local menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        emoji = '[Emoji]',
        path = '[Path]',
        calc = '[Calc]',
        neorg = '[Neorg]',
        orgmode = '[Org]',
        cmp_tabnine = '[TN]',
        luasnip = '[Luasnip]',
        buffer = '[Buffer]',
        fuzzy_buffer = '[Fuzzy Buffer]',
        fuzzy_path = '[Fuzzy Path]',
        spell = '[Spell]',
        cmdline = '[Command]',
      })[name]

      if name == 'cmp_tabnine' then
        if completion and completion.detail then
          menu = completion.detail .. ' ' .. menu
        end
        vim_item.kind = ''
      end
      vim_item.menu = menu
      return vim_item
    end,
  },
  documentation = {
    border = 'rounded',
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'cmp_tabnine' },
    { name = 'nvim_lua' },
    { name = 'spell' },
    { name = 'path' },
  }, {
    { name = 'fuzzy_buffer' },
  }),
}

local search_sources = {
  completion = {
    keyword_length = 2, -- avoid keyword completion
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'fuzzy_buffer' },
  }),
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', search_sources)

cmp.setup.cmdline('?', search_sources)

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = {
    keyword_length = 2, -- avoid keyword completion
  },
  sources = cmp.config.sources({
    { name = 'fuzzy_path' },
  }, {
    { name = 'cmdline' },
  }),
})
