return {
    {
    'nvim-telescope/telescope.nvim',
        branch = 'master',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        opts = {
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {
              }
            }
          }
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {noremap = true})
            vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, {noremap = true})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {noremap = true})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {noremap = true})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {noremap = true})
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    }
}
