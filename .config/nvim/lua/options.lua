
local o = vim.opt

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"
o.compatible = false
o.syntax = "on"
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.smartindent = true
o.ruler = true
o.mouse = "a"
o.tags = "tags"
o.number = true
o.shiftwidth = 4
o.tabstop = 4
o.smarttab = true
o.expandtab = true
o.foldenable = false
o.sidescrolloff = 5
o.scrolloff = 5
o.wrap = true
o.linebreak = true
o.history = 9999
o.encoding = "utf-8"
o.updatetime = 10
o.omnifunc = "syntaxcomplete#Complete"
o.termguicolors = true
o.list = true
o.swapfile = false
-- o.ttymouse = "sgr"
-- Spellcheck
o.spell = true
o.spelllang = "en_us"
o.signcolumn = "number"
o.completeopt = {'menu', 'menuone', 'noselect'}
vim.api.nvim_set_option_value("colorcolumn", "80", {})

_G.enable_virtual_lines = false -- only works in neovim 0.11+



-- Set tab width = 2 spaces for JS/TS files
vim.api.nvim_create_augroup("SetTwoSpaceIndent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "SetTwoSpaceIndent",
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})



vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'j', 'gj', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'k', 'gk', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<esc>', '<esc>:noh<cr>', { noremap = true, silent = true })

-- Set all floating windows to have these defaults unless overridden
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = opts.max_width or 80
  opts.max_height = opts.max_height or 15
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
