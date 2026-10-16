return {
  --'mei28/nvim-overleaf',
  --dependencies = { 'vim-denops/denops.vim' },
  --opts = {
    --autoread = true,
  --}
    {
      'richwomanbtc/overleaf.nvim',
      config = function()
        local overleaf = require('overleaf')
        overleaf.setup({ sync_dir = vim.fn.getcwd() })

        -- Overleaf's PDF download saves an empty file (upstream issue #24),
        -- so build from the synced files with vimtex instead.
        overleaf.compile = function()
          if not vim.b.vimtex then
            vim.notify('[overleaf] open a .tex document to compile', vim.log.levels.WARN)
            return
          end
          -- Edits reach disk on a 500ms debounce. Flush them so latexmk sees the buffer as saved.
          local sync = require('overleaf.sync')
          for _, doc in pairs(overleaf._state.documents) do
            sync.write_doc(doc)
          end
          vim.cmd('VimtexCompile')
        end
      end,
      build = 'cd node && NPM_CONFIG_ALLOW_GIT="all" npm install',
    }
}
