return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        opts = function()
            return {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.setup(opts)
            telescope.load_extension("ui-select")
        end,
        cmd = {
            "Telescope",
        },
        keys = {
            {
                "<leader>ff",
                "<cmd>Telescope find_files<cr>",
                desc = "Find files",
            },
            {
                "<leader>fs",
                "<cmd>Telescope spell_suggest<cr>",
                desc = "Spell suggest",
            },
            {
                "<leader>fg",
                "<cmd>Telescope live_grep<cr>",
                desc = "Live grep",
            },
            {
                "<leader>fb",
                "<cmd>Telescope buffers<cr>",
                desc = "Buffers",
            },
            {
                "<leader>fh",
                "<cmd>Telescope help_tags<cr>",
                desc = "Help tags",
            },
            {
                "<leader>gi",
                "<cmd>Telescope lsp_implementations<cr>",
                desc = "LSP implementations",
            },
            {
                "<leader>gr",
                "<cmd>Telescope lsp_references<cr>",
                desc = "LSP references",
            },
        },
    },
}
