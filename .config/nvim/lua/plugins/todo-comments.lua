return {
    {
        "folke/todo-comments.nvim",
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
        end,
        keys = {
            {
                "<leader>tt",
                ":TodoTelescope<CR>",
                mode = "n",
                noremap = true,
                desc = "Search for TODO comments throughout project using Telescope."
            },
            {
                "<leader>tl",
                ":TodoLocList<CR>",
                mode = "n",
                noremap = true,
                desc = "Search for TODO comments throughout project and show in Loc List."
            }
        }
    },
}
