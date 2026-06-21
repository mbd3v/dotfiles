return {
    {
        "folke/todo-comments.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            -- None right now. Defaults are pretty good
        },
        config = function()
            local todo_plugin = require("todo-comments")
            todo_plugin.setup()
            vim.api.nvim_set_keymap("n", "<leader>tt", ":TodoTelescope<CR>", {noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>tl", ":TodoLocList<CR>", {noremap = true})
        end
    },
}
