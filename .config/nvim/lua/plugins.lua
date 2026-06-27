return {
    "stevearc/dressing.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "ryanoasis/vim-devicons",
    {
        "preservim/nerdcommenter",
        init = function()
            vim.g.NERDCreateDefaultMappings = 0
        end,
        keys = {
            {
                "<leader>cc",
                "<Plug>NERDCommenterComment",
                mode = { "n", "x" },
                noremap = true,
                desc = "Comment current line or multiple lines in visual mode."
            },
            {
                "<leader>cu",
                "<Plug>NERDCommenterUncomment",
                mode = { "n", "x" },
                noremap = true,
                desc = "Uncomment current line or multiple lines in visual mode."
            },
            {
                "<leader>cA",
                "<Plug>NERDCommenterAppend",
                mode = "n",
                noremap = true,
                desc = "Append comment to the end of current line."
            },
        },
    },
    {
        "Xuyuanp/nerdtree-git-plugin",
    },
    {"habamax/vim-asciidoctor", ft = {"adoc", "asciidoctor"}},
    {"mfussenegger/nvim-jdtls", ft = {"java"}},
}
