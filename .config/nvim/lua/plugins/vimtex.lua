return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'zathura_simple'
    vim.g.vimtex_compiler_latexmk = { continuous = 0 }
  end,
}
