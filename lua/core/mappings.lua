local fn = vim.fn
local api = vim.api
local command = global.command
local fmt = string.format
local map = global.map

-- Basic Mapping
map("n", "\\", ",")
map("n", "<BS>", "<C-^>")
map("n", "<Esc>", ":nohl<CR>")
map({"n", "x", "o"}, "<Tab>", "%", { noremap = false })
map({"n", "x", "o"}, "H", "^")
map({"n", "x", "o"}, "L", "$")
map({"n", "x"}, "<Leader><Leader>", ":", { silent = false })
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
-- don't yank text on cut ( x )
map({ "n", "v" }, "x", '"_x')
-- don't yank text on delete ( dd )
map({ "n", "v" }, "d", '"_d')
-- Toggle case of current word
map("n", "<C-u>", "mzg~iw`z")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Insert Mode Mapping
map("i", "<C-p>", "<Esc>pa")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")
map("i", "<C-k>", "<Esc>O")
map("i", "<C-j>", "<Esc>o")
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-l>", "<End>")
map("i", "<C-w>", "<C-[>diwa")
map("i", "<C-h>", "<BS>")
map("i", "<C-d>", "<Del>")
map("i", "<C-u>", "<C-G>u<C-U>")
map("i", "<C-s>", "<Esc>:w<CR>")
map("i", "<C-q>", "<Esc>:wq<CR>")

-- Commandline Mapping
map("c", "<C-b>", "<Left>")
map("c", "<C-f>", "<Right>")
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-d>", "<Del>")
map("c", "<C-h>", "<BS>")
map("c", "<C-t>", [[<C-R>=expand("%:p:h") . "/" <CR>]])

-- Plugins Mapping
-- Add Packer commands because we are not loading it at startup
vim.cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
vim.cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"
