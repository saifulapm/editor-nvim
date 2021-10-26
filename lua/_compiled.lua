-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/saiful/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/saiful/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/saiful/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/saiful/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/saiful/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.luasnip\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/LuaSnip"
  },
  ["auto-session"] = {
    commands = { "RestoreSession", "SaveSession" },
    config = { "\27LJ\2\n´\1\0\0\t\0\v\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0'\3\3\0\18\5\3\0009\3\4\0036\6\5\0009\6\6\0069\6\a\6'\b\b\0B\6\2\0A\3\1\2=\3\n\2B\0\2\1K\0\1\0\26auto_session_root_dir\1\0\0\tdata\fstdpath\afn\bvim\vformat\21%s/session/auto/\nsetup\17auto-session\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/auto-session"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18better_escape\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/better-escape.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.bufferline\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/bufferline.nvim"
  },
  ["chartoggle.nvim"] = {
    config = { "\27LJ\2\ni\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\tkeys\1\3\0\0\6,\6;\1\0\1\vleader\18<localleader>\nsetup\15chartoggle\frequire\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/chartoggle.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    config = { "\27LJ\2\n¶\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0K\0\1\0\17^>>>>>>> .*$\24conflict_marker_end\17^<<<<<<< .*$\26conflict_marker_begin\5$conflict_marker_highlight_group\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/conflict-marker.vim"
  },
  ["dart-vim-plugin"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\nÙ\2\0\0\a\0\24\0!6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\4\0009\2\5\0025\4\6\0005\5\a\0=\5\b\4B\2\2\2=\2\3\0016\1\t\0009\1\n\0019\3\v\0009\3\f\0039\3\r\3'\4\3\0B\1\3\0016\1\14\0009\1\15\0015\3\16\0'\4\17\0'\5\18\0005\6\19\0B\1\5\0016\1\14\0009\1\15\0015\3\20\0'\4\21\0'\5\22\0005\6\23\0B\1\5\1K\0\1\0\1\0\1\fnoremap\1\27<Plug>(dial-decrement)\6-\1\3\0\0\6n\6v\1\0\1\fnoremap\1\27<Plug>(dial-increment)\6+\1\3\0\0\6n\6v\bmap\vglobal\vnormal\15searchlist\vconfig\vinsert\ntable\fstrlist\1\3\0\0\ttrue\nfalse\1\0\1\tname\fboolean\16enum_cyclic\vcommon\19custom#boolean\faugends\tdial\frequire\0" },
    keys = { { "n", "-" }, { "n", "+" }, { "v", "-" }, { "v", "+" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/dial.nvim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen", "DiffviewFileHistory" },
    config = { "\27LJ\2\nø\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\17key_bindings\tview\1\0\1\6q\27<Cmd>DiffviewClose<CR>\15file_panel\1\0\0\1\0\1\6q\27<Cmd>DiffviewClose<CR>\1\0\1\21enhanced_diff_hl\2\nsetup\rdiffview\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["editorconfig.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/editorconfig.nvim"
  },
  ["emmet-vim"] = {
    commands = { "EmmetInstall" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  ["feline.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19plugins.feline\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/feline.nvim"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\nÜ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\14overrides\1\0\0\fliteral\1\0\0\1\0\2\15.gitignore\tconf\15kitty.conf\nkitty\nsetup\rfiletype\frequire\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/filetype.nvim"
  },
  ["gitlinker.nvim"] = {
    config = { "\27LJ\2\n{\0\0\6\1\6\0\n-\0\0\0009\0\0\0005\2\4\0006\3\1\0'\5\2\0B\3\2\0029\3\3\3=\3\5\2B\0\2\1K\0\1\0\0¿\20action_callback\1\0\0\20open_in_browser\22gitlinker.actions\frequire\17get_repo_urlë\1\1\0\6\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0009\1\5\1'\3\6\0'\4\a\0003\5\b\0B\1\4\0012\0\0ÄK\0\1\0\0\20<localleader>go\6n\bmap\vglobal\1\0\1\rmappings\20<localleader>gu\nsetup\14gitlinker\frequire\0" },
    keys = { { "", "<localleader>gu" }, { "", "<localleader>go" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/gitlinker.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  himalaya = {
    commands = { "Himalaya" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/himalaya/vim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nz\0\0\6\1\a\0\v-\0\0\0009\0\0\0005\2\5\0006\3\1\0'\5\2\0B\3\2\0029\3\3\0039\3\4\3=\3\6\2B\0\2\1K\0\1\0\0¿\14direction\1\0\0\18BEFORE_CURSOR\18HintDirection\rhop.hint\frequire\15hint_char1y\0\0\6\1\a\0\v-\0\0\0009\0\0\0005\2\5\0006\3\1\0'\5\2\0B\3\2\0029\3\3\0039\3\4\3=\3\6\2B\0\2\1K\0\1\0\0¿\14direction\1\0\0\17AFTER_CURSOR\18HintDirection\rhop.hint\frequire\15hint_char1Œ\1\1\0\6\0\15\0\0266\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\0016\1\4\0009\1\5\1'\3\6\0'\4\a\0009\5\b\0B\1\4\0016\1\4\0009\1\5\0015\3\t\0'\4\n\0003\5\v\0B\1\4\0016\1\4\0009\1\5\0015\3\f\0'\4\r\0003\5\14\0B\1\4\0012\0\0ÄK\0\1\0\0\6f\1\3\0\0\6o\6x\0\6F\1\3\0\0\6o\6x\15hint_char1\6s\6n\bmap\vglobal\1\0\1\tkeys\25etovxqpdygfbzcisuran\nsetup\bhop\frequire\0" },
    keys = { { "n", "s" }, { "o", "f" }, { "x", "f" }, { "o", "F" }, { "x", "F" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  ["lsp-fastaction.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.fastaction\frequire\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/lsp-fastaction.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nZ\0\2\4\0\2\0\14:\2\1\0009\2\0\2)\3\0\0\3\3\2\0X\2\5Ä:\2\1\0009\2\1\2)\3\1\0\0\3\2\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\15parameters\20activeParameterç\1\1\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\17handler_opts\1\0\1\vborder\frounded\ffix_pos\0\1\0\2\tbind\2\16hint_enable\1\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["luv-vimdocs"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/luv-vimdocs"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0K\0\1\0\20mkdp_auto_close\20mkdp_auto_start\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\nm\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15bookmark_0\1\0\0\1\0\2\tsign\b‚öë\14virt_text\14bookmarks\nsetup\nmarks\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/marks.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\topen-\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\2\0\0\vcommit\topenÑ\4\1\0\6\0\27\0.6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\4=\4\v\0035\4\f\0=\4\r\3B\1\2\0016\1\14\0009\1\15\1'\3\16\0'\4\17\0003\5\18\0B\1\4\0016\1\14\0009\1\15\1'\3\16\0'\4\19\0003\5\20\0B\1\4\0016\1\14\0009\1\15\1'\3\16\0'\4\21\0009\5\22\0009\5\23\0059\5\24\5B\1\4\0016\1\14\0009\1\15\1'\3\16\0'\4\25\0009\5\22\0009\5\26\0059\5\24\5B\1\4\0012\0\0ÄK\0\1\0\tpush\20<localleader>gp\vcreate\tpull\vpopups\20<localleader>gl\0\20<localleader>gc\0\20<localleader>gs\6n\bmap\vglobal\17integrations\1\0\1\rdiffview\2\nsigns\thunk\1\3\0\0\bÔ§î\bÔ°≥\titem\1\3\0\0\b‚ñ∏\b‚ñæ\fsection\1\0\0\1\3\0\0\5\5\1\0\5\18disable_signs\1\17disable_hint\2 disable_commit_confirmation\2\"disable_builtin_notifications\2\29disable_insert_on_commit\1\nsetup\vneogit\frequire\0" },
    keys = { { "", "<localleader>gs" }, { "", "<localleader>gl" }, { "", "<localleader>gp" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\në\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rmappings\1\0\2\rstop_eof\1\16hide_cursor\2\1\t\0\0\n<C-u>\n<C-d>\n<C-b>\n<C-f>\n<C-y>\azt\azz\azb\nsetup\14neoscroll\frequire\0" },
    keys = { { "", "<C-u>" }, { "", "<C-d>" }, { "", "<C-b>" }, { "", "<C-f>" }, { "", "<C-y>" }, { "", "zt" }, { "", "zz" }, { "", "zb" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\næ\1\0\0\3\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\2\0005\2\5\0B\0\2\1K\0\1\0\1\0\3\16auto_select\2\17map_complete\2\vmap_cr\2\"nvim-autopairs.completion.cmp\1\0\2\rcheck_ts\1\24close_triple_quotes\2\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-base16.lua"] = {
    after = { "feline.nvim", "bufferline.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-bqf"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "nvim-autopairs", "cmp-buffer", "cmp-path", "cmp_luasnip", "cmp-cmdline", "tabout.nvim" },
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    commands = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    config = { "\27LJ\2\n£\2\0\0\4\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\thtml\1\0\1\tmode\15foreground\ttmux\1\0\1\nnames\1\bvim\1\0\1\nnames\2\vstylus\1\0\1\vrgb_fn\2\tsass\1\0\1\vrgb_fn\2\tscss\1\0\1\vrgb_fn\2\bcss\1\5\0\0\15javascript\20javascriptreact\15typescript\20typescriptreact\1\0\1\vrgb_fn\2\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-hclipboard"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nstart\15hclipboard\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-hclipboard"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    commands = { "Luapad" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-luapad"
  },
  ["nvim-luaref"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/nvim-luaref"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\nú\2\0\0\6\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0B\3\2\2'\4\b\0&\3\4\3=\3\t\0025\3\v\0005\4\n\0=\4\f\0035\4\r\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\tkeys\6n\1\0\3\npaste\6p\17paste_behind\6P\vselect\t<CR>\6i\1\0\0\1\0\3\npaste\n<c-p>\17paste_behind\n<c-k>\vselect\t<CR>\fdb_path\21/neoclip.sqlite3\tdata\fstdpath\afn\bvim\1\0\1\30enable_persistant_history\2\nsetup\fneoclip\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-neoclip.lua"
  },
  ["nvim-pqf"] = {
    config = { "\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\0\1\0\4\nerror\b‚úó\tinfo\bÔ†µ\fwarning\bÔÅ±\thint\bÔÇ≠\nsetup\bpqf\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-pqf"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.nvimtree\frequire\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "treesitter-unit", "nvim-ts-rainbow", "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["spellsitter.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/spellsitter.nvim"
  },
  ["splitjoin.vim"] = {
    keys = { { "", "gS" }, { "", "gJ" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/splitjoin.vim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/sqlite.lua"
  },
  ["tabout.nvim"] = {
    config = { "\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\21ignore_beginning\1\15completion\1\nsetup\vtabout\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/tabout.nvim",
    wants = { "nvim-treesitter" }
  },
  ["telescope-frecency.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim"
  },
  ["telescope-smart-history.nvim"] = {
    config = { "\27LJ\2\nR\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\18smart_history\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/telescope-smart-history.nvim"
  },
  ["telescope-tmux.nvim"] = {
    config = { "\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\ttmux\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/telescope-tmux.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-fzf-native.nvim", "telescope-smart-history.nvim", "telescope-tmux.nvim", "telescope-frecency.nvim" },
    commands = { "Telescope" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0" },
    keys = { { "", "<c-p>" }, { "", "<leader>fo" }, { "", "<leader>ff" }, { "", "<leader>fs" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\nœ\1\0\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0'\3\v\0'\4\f\0B\0\4\1K\0\1\0\25<Cmd>TodoTrouble<CR>\15<leader>lt\6n\bmap\vglobal\14highlight\1\0\0\fexclude\1\0\0\1\5\0\0\borg\14orgagenda\fvimwiki\rmarkdown\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nå\1\0\1\4\0\b\1\0179\1\0\0\a\1\1\0X\1\3Ä)\1\15\0L\1\2\0X\1\nÄ9\1\0\0\a\1\2\0X\1\aÄ6\1\3\0009\1\4\0016\3\5\0009\3\6\0039\3\a\3\24\3\0\3D\1\2\0K\0\1\0\fcolumns\6o\bvim\nfloor\tmath\rvertical\15horizontal\14directionµÊÃô\19ô≥Ê˛\3ù\1\0\1\6\0\n\0\0236\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\4\0B\1\3\2\6\1\5\0X\1\14Ä6\1\0\0009\1\6\0019\1\a\0019\3\b\0'\4\4\0'\5\3\0B\1\4\0016\1\0\0009\1\6\0019\1\a\0019\3\b\0'\4\4\0'\5\t\0B\1\4\1K\0\1\0\n<esc>\nbufnr\24nvim_buf_del_keymap\bapi\5\6t\ajk\rmapcheck\afn\bvim$\0\0\3\1\1\0\5-\0\0\0\18\2\0\0009\0\0\0B\0\2\1K\0\1\0\2¿\vtoggle$\0\0\3\1\1\0\5-\0\0\0\18\2\0\0009\0\0\0B\0\2\1K\0\1\0\3¿\vtoggleÔ\3\1\0\b\0\23\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0023\3\b\0=\3\t\2B\0\2\0013\0\n\0006\1\0\0'\3\v\0B\1\2\0029\1\f\1\18\4\1\0009\2\r\0015\5\14\0=\0\15\5B\2\3\0026\3\16\0009\3\17\0035\5\18\0003\6\19\0>\6\2\5B\3\2\1\18\5\1\0009\3\r\0015\6\20\0=\0\15\6B\3\3\0026\4\16\0009\4\17\0045\6\21\0003\a\22\0>\a\2\6B\4\2\0012\0\0ÄK\0\1\0\0\1\2\0\0\tHtop\1\0\3\vhidden\ttrue\14direction\nfloat\bcmd\thtop\0\1\2\0\0\fLazygit\fcommand\vglobal\fon_open\1\0\4\bdir\fgit_dir\vhidden\2\14direction\nfloat\bcmd\flazygit\bnew\rTerminal\24toggleterm.terminal\0\tsize\0\15float_opts\1\0\2\vborder\vcurved\rwinblend\3\3\20shade_filetypes\1\2\0\0\tnone\1\0\3\20start_in_insert\2\14direction\rvertical\17open_mapping\n<c-\\>\nsetup\15toggleterm\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim"
  },
  ["treesitter-unit"] = {
    config = { "\27LJ\2\nº\2\0\0\5\0\n\0\0256\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\5\0'\4\6\0B\0\4\0016\0\0\0009\0\1\0'\2\a\0'\3\3\0'\4\b\0B\0\4\0016\0\0\0009\0\1\0'\2\a\0'\3\5\0'\4\t\0B\0\4\1K\0\1\0007<Cmd>lua require\"treesitter-unit\".select(true)<CR>3<Cmd>lua require\"treesitter-unit\".select()<CR>\6o3:lua require\"treesitter-unit\".select(true)<CR>\aau/:lua require\"treesitter-unit\".select()<CR>\aiu\6x\bmap\vglobal\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/treesitter-unit"
  },
  ["trouble.nvim"] = {
    commands = { "TroubleToggle" },
    config = { "\27LJ\2\n<\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\0\2\tjump\2\16skip_groups\2\rprevious8\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\0\2\tjump\2\16skip_groups\2\tnextº\2\1\0\6\0\15\0 6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\1'\3\4\0'\4\5\0'\5\6\0B\1\4\0016\1\2\0009\1\3\1'\3\4\0'\4\a\0'\5\b\0B\1\4\0016\1\2\0009\1\3\1'\3\4\0'\4\t\0003\5\n\0B\1\4\0016\1\2\0009\1\3\1'\3\4\0'\4\v\0003\5\f\0B\1\4\0019\1\r\0005\3\14\0B\1\2\0012\0\0ÄK\0\1\0\1\0\2\15auto_close\2\17auto_preview\1\nsetup\0\a[t\0\a]t*<cmd>TroubleToggle lsp_references<CR>\15<leader>lr5<cmd>TroubleToggle lsp_workspace_diagnostics<CR>\15<leader>ld\6n\bmap\vglobal\ftrouble\frequire\0" },
    keys = { { "", "<leader>ld" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "\27LJ\2\nh\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0 undotree_SetFocusWhenToggle\b‚óâ\27undotree_TreeNodeShape\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-abolish"] = {
    config = { "\27LJ\2\nÔ\1\0\0\a\0\t\0\0235\0\0\0006\1\1\0009\1\2\1'\3\3\0'\4\4\0'\5\5\0\18\6\0\0B\1\5\0016\1\1\0009\1\2\1'\3\3\0'\4\6\0'\5\a\0\18\6\0\0B\1\5\0016\1\1\0009\1\2\1'\3\3\0'\4\4\0'\5\b\0\18\6\0\0B\1\5\1K\0\1\0&\"zy:%S/<C-r><C-o>\"//c<left><left>\":%S/<C-r><C-w>//c<left><left>\19<localleader>]\26:S/<C-R><C-W>//<LEFT>\19<localleader>[\6n\bmap\vglobal\1\0\1\vsilent\1\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-abolish"
  },
  ["vim-apathy"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-apathy"
  },
  ["vim-asterisk"] = {
    config = { "\27LJ\2\n†\1\0\0\6\0\n\0\0156\0\0\0009\0\1\0005\2\2\0'\3\3\0'\4\4\0005\5\5\0B\0\5\0016\0\0\0009\0\1\0005\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\23<Plug>(asterisk-#)\6#\1\3\0\0\6n\6v\1\0\1\fnoremap\1\23<Plug>(asterisk-*)\6*\1\3\0\0\6n\6v\bmap\vglobal\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-asterisk"
  },
  ["vim-eunuch"] = {
    commands = { "Delete", "Move", "Rename", "Chmod", "Mkdir", "Wall", "SudoWrite", "SudoEdit" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-eunuch"
  },
  ["vim-exchange"] = {
    config = { "\27LJ\2\n«\1\0\0\6\0\r\0\0196\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\3\0009\0\4\0005\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\3\0009\0\4\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\26<Plug>(ExchangeClear)\aXc\6n\1\0\1\fnoremap\1\21<Plug>(Exchange)\6X\1\3\0\0\6n\6x\bmap\vglobal\25exchange_no_mappings\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-exchange"
  },
  ["vim-fold-cycle"] = {
    config = { "\27LJ\2\nè\1\0\0\6\0\t\0\f6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\29<Plug>(fold-cycle-close)\t<BS>\6n\bmap\vglobal\31fold_cycle_default_mapping\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-fold-cycle"
  },
  ["vim-highlighturl"] = {
    config = { "\27LJ\2\n<\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\f#51afef\23highlighturl_guifg\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-highlighturl"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\nŸ\1\0\0\5\0\a\0\r6\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0M<cmd> lua require\"illuminate\".next_reference{reverse=true,wrap=true}<CR>\n<A-p>@<cmd> lua require\"illuminate\".next_reference{wrap=true}<CR>\n<A-n>\6n\bmap\vglobal\0" },
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/vim-illuminate"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-matchup"] = {
    after_files = { "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  ["vim-niceblock"] = {
    config = { "\27LJ\2\n‘\1\0\0\6\0\f\0\0226\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0005\5\5\0B\0\5\0016\0\0\0009\0\1\0'\2\2\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\0\0009\0\1\0'\2\2\0'\3\t\0'\4\n\0005\5\v\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\24<Plug>(niceblock-A)\6A\1\0\1\fnoremap\1\25<Plug>(niceblock-gI)\agI\1\0\1\fnoremap\1\24<Plug>(niceblock-I)\6I\6x\bmap\vglobal\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-niceblock"
  },
  ["vim-operator-replace"] = {
    config = { "\27LJ\2\nk\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\29<Plug>(operator-replace)\6p\6x\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "x", "p" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-operator-replace"
  },
  ["vim-operator-surround"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-operator-surround"
  },
  ["vim-operator-user"] = {
    loaded = true,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/start/vim-operator-user"
  },
  ["vim-projectionist"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugins.projectionist\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-repeat"
  },
  ["vim-sleuth"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-sleuth"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "\27LJ\2\n|\0\0\2\0\5\0\t6\0\0\0009\0\1\0)\1\15\0=\1\2\0006\0\0\0009\0\1\0005\1\4\0=\1\3\0K\0\1\0\1\2\0\0$+let g:auto_session_enabled = 0\25startuptime_exe_args\22startuptime_tries\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-subversive"] = {
    config = { "\27LJ\2\n_\0\0\6\0\6\0\b6\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0005\5\5\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1!<plug>(SubversiveSubstitute)\6S\6n\bmap\vglobal\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-surround"
  },
  ["vim-textobj-comment"] = {
    config = { "\27LJ\2\n≤\2\0\0\6\0\15\0!6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\3\0009\0\4\0'\2\t\0'\3\6\0'\4\a\0005\5\n\0B\0\5\0016\0\3\0009\0\4\0'\2\5\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\3\0009\0\4\0'\2\t\0'\3\v\0'\4\f\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\1\0\1\fnoremap\1\30<Plug>(textobj-comment-i)\aix\1\0\1\fnoremap\1\6o\1\0\1\fnoremap\1\30<Plug>(textobj-comment-a)\aax\6x\bmap\vglobal,textobj_comment_no_default_key_mappings\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-textobj-comment"
  },
  ["vim-tmux-navigator"] = {
    config = { "\27LJ\2\n∂\3\0\0\5\0\17\0)6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\0016\0\3\0009\0\4\0'\2\5\0'\3\b\0'\4\t\0B\0\4\0016\0\3\0009\0\4\0'\2\5\0'\3\n\0'\4\v\0B\0\4\0016\0\3\0009\0\4\0'\2\5\0'\3\f\0'\4\r\0B\0\4\0016\0\0\0009\0\1\0)\1\1\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\15\0006\0\0\0009\0\1\0)\1\2\0=\1\16\0K\0\1\0\"tmux_navigator_save_on_switch!tmux_navigator_preserve_zoom'tmux_navigator_disable_when_zoomed\31<cmd>TmuxNavigateRight<cr>\n<C-L>\28<cmd>TmuxNavigateUp<cr>\n<C-K>\30<cmd>TmuxNavigateDown<cr>\n<C-J>\30<cmd>TmuxNavigateLeft<cr>\n<C-H>\6n\bmap\vglobal\31tmux_navigator_no_mappings\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\n—\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0K\0\1\0\1\0\4\23Find Subword Under\n<C-e>\21Select Cursor Up\a\\k\15Find Under\n<C-e>\23Select Cursor Down\a\\j\fVM_maps\rcodedark\rVM_theme\14underline\25VM_highlight_matches\6g\bvim\0" },
    keys = { { "", "<C-e>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-visual-multi"
  },
  vimwiki = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20plugins.vimwiki\frequire\0" },
    keys = { { "", "<leader>ww" }, { "", "<leader>wt" }, { "", "<leader>wi" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/saiful/.local/share/nvim/site/pack/packer/opt/vimwiki"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/Users/saiful/.local/share/nvim/site/pack/packer/opt/himalaya/vim"
time([[Runtimepath customization]], false)
local module_lazy_loads = {
  ["^cmp"] = "nvim-cmp",
  ["^luasnip"] = "LuaSnip",
  ["telescope.*"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: todo-comments.nvim
time([[Setup for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\23todo-comments.nvim\tlazy\nutils\frequire\0", "setup", "todo-comments.nvim")
time([[Setup for todo-comments.nvim]], false)
-- Setup for: vim-subversive
time([[Setup for vim-subversive]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\19vim-subversive\tlazy\nutils\frequire\0", "setup", "vim-subversive")
time([[Setup for vim-subversive]], false)
-- Setup for: vim-exchange
time([[Setup for vim-exchange]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17vim-exchange\tlazy\nutils\frequire\0", "setup", "vim-exchange")
time([[Setup for vim-exchange]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\18gitsigns.nvim\tlazy\nutils\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: editorconfig.nvim
time([[Setup for editorconfig.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\22editorconfig.nvim\tlazy\nutils\frequire\0", "setup", "editorconfig.nvim")
time([[Setup for editorconfig.nvim]], false)
-- Setup for: toggleterm.nvim
time([[Setup for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\20toggleterm.nvim\tlazy\nutils\frequire\0", "setup", "toggleterm.nvim")
time([[Setup for toggleterm.nvim]], false)
-- Setup for: emmet-vim
time([[Setup for emmet-vim]], true)
try_loadstring("\27LJ\2\n∞\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\6i\20user_emmet_mode\31user_emmet_install_command\30user_emmet_install_global\28user_emmet_complete_tag\6g\bvim\0", "setup", "emmet-vim")
time([[Setup for emmet-vim]], false)
-- Setup for: vimwiki
time([[Setup for vimwiki]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20plugins.vimwiki\frequire\0", "setup", "vimwiki")
time([[Setup for vimwiki]], false)
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\nI\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\23vim-tmux-navigator\tlazy\nutils\frequire\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
-- Setup for: vim-abolish
time([[Setup for vim-abolish]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\16vim-abolish\tlazy\nutils\frequire\0", "setup", "vim-abolish")
time([[Setup for vim-abolish]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\16vim-matchup\tlazy\nutils\frequire\0", "setup", "vim-matchup")
time([[Setup for vim-matchup]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.nvimtree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\nÜ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\14overrides\1\0\0\fliteral\1\0\0\1\0\2\15.gitignore\tconf\15kitty.conf\nkitty\nsetup\rfiletype\frequire\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: chartoggle.nvim
time([[Config for chartoggle.nvim]], true)
try_loadstring("\27LJ\2\ni\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\tkeys\1\3\0\0\6,\6;\1\0\1\vleader\18<localleader>\nsetup\15chartoggle\frequire\0", "config", "chartoggle.nvim")
time([[Config for chartoggle.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\nŸ\1\0\0\5\0\a\0\r6\0\0\0009\0\1\0'\2\2\0'\3\3\0'\4\4\0B\0\4\0016\0\0\0009\0\1\0'\2\2\0'\3\5\0'\4\6\0B\0\4\1K\0\1\0M<cmd> lua require\"illuminate\".next_reference{reverse=true,wrap=true}<CR>\n<A-p>@<cmd> lua require\"illuminate\".next_reference{wrap=true}<CR>\n<A-n>\6n\bmap\vglobal\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: lsp-fastaction.nvim
time([[Config for lsp-fastaction.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.fastaction\frequire\0", "config", "lsp-fastaction.nvim")
time([[Config for lsp-fastaction.nvim]], false)
-- Config for: nvim-base16.lua
time([[Config for nvim-base16.lua]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tinit\vcolors\frequire\0", "config", "nvim-base16.lua")
time([[Config for nvim-base16.lua]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\2\4\0\2\0\14:\2\1\0009\2\0\2)\3\0\0\3\3\2\0X\2\5Ä:\2\1\0009\2\1\2)\3\1\0\0\3\2\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\15parameters\20activeParameterç\1\1\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\17handler_opts\1\0\1\vborder\frounded\ffix_pos\0\1\0\2\tbind\2\16hint_enable\1\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd feline.nvim ]]

-- Config for: feline.nvim
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19plugins.feline\frequire\0", "config", "feline.nvim")

vim.cmd [[ packadd bufferline.nvim ]]

-- Config for: bufferline.nvim
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.bufferline\frequire\0", "config", "bufferline.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file RestoreSession lua require("packer.load")({'auto-session'}, { cmd = "RestoreSession", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SaveSession lua require("packer.load")({'auto-session'}, { cmd = "SaveSession", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewFileHistory lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewFileHistory", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Delete lua require("packer.load")({'vim-eunuch'}, { cmd = "Delete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Move lua require("packer.load")({'vim-eunuch'}, { cmd = "Move", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Rename lua require("packer.load")({'vim-eunuch'}, { cmd = "Rename", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Chmod lua require("packer.load")({'vim-eunuch'}, { cmd = "Chmod", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Mkdir lua require("packer.load")({'vim-eunuch'}, { cmd = "Mkdir", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Wall lua require("packer.load")({'vim-eunuch'}, { cmd = "Wall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudoWrite lua require("packer.load")({'vim-eunuch'}, { cmd = "SudoWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudoEdit lua require("packer.load")({'vim-eunuch'}, { cmd = "SudoEdit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerDetachFromBuffer lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerDetachFromBuffer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EmmetInstall lua require("packer.load")({'emmet-vim'}, { cmd = "EmmetInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerReloadAllBuffers lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerReloadAllBuffers", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerAttachToBuffer lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerAttachToBuffer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Himalaya lua require("packer.load")({'himalaya'}, { cmd = "Himalaya", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Luapad lua require("packer.load")({'nvim-luapad'}, { cmd = "Luapad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerToggle lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <c-p> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>c-p>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[onoremap <silent> f <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> - <cmd>lua require("packer.load")({'dial.nvim'}, { keys = "-", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-e> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-e>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>wt <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>wt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-f> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-f>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ff <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>ff", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> - <cmd>lua require("packer.load")({'dial.nvim'}, { keys = "-", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ld <cmd>lua require("packer.load")({'trouble.nvim'}, { keys = "<lt>leader>ld", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> F <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> + <cmd>lua require("packer.load")({'dial.nvim'}, { keys = "+", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-d> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-d>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> zt <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "zt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>gu <cmd>lua require("packer.load")({'gitlinker.nvim'}, { keys = "<lt>localleader>gu", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>gp <cmd>lua require("packer.load")({'neogit'}, { keys = "<lt>localleader>gp", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> p <cmd>lua require("packer.load")({'vim-operator-replace'}, { keys = "p", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> f <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-b> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-b>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>fs <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>fs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> + <cmd>lua require("packer.load")({'dial.nvim'}, { keys = "+", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[onoremap <silent> F <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ww <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>ww", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>gl <cmd>lua require("packer.load")({'neogit'}, { keys = "<lt>localleader>gl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> zb <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "zb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>wi <cmd>lua require("packer.load")({'vimwiki'}, { keys = "<lt>leader>wi", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>gs <cmd>lua require("packer.load")({'neogit'}, { keys = "<lt>localleader>gs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-y> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-y>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gJ <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gJ", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> s <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gS <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-u> <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "<lt>C-u>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> zz <cmd>lua require("packer.load")({'neoscroll.nvim'}, { keys = "zz", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>go <cmd>lua require("packer.load")({'gitlinker.nvim'}, { keys = "<lt>localleader>go", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>fo <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>fo", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-apathy'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-apathy', 'nvim-colorizer.lua'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType dart ++once lua require("packer.load")({'dart-vim-plugin'}, { ft = "dart" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "sass" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'vim-apathy'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-apathy'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf', 'nvim-pqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'indent-blankline.nvim', 'marks.nvim', 'Comment.nvim', 'vim-highlighturl', 'nvim-neoclip.lua', 'vim-niceblock', 'vim-operator-surround', 'nvim-hclipboard', 'vim-fold-cycle', 'vim-textobj-comment', 'vim-projectionist', 'vim-surround', 'vim-repeat'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'vim-asterisk', 'nvim-treesitter', 'vim-sleuth', 'conflict-marker.vim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter *.wiki ++once lua require("packer.load")({'vimwiki'}, { event = "BufEnter *.wiki" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'LuaSnip', 'nvim-cmp', 'better-escape.nvim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/saiful/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/saiful/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]], true)
vim.cmd [[source /Users/saiful/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]]
time([[Sourcing ftdetect script at: /Users/saiful/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
