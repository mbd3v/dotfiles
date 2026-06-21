return {
    {
        "airblade/vim-gitgutter",
        lazy = true,
        config = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                command = "GitGutterEnable"
            })
            vim.api.nvim_create_autocmd("BufWritePost", {
                command = "GitGutter"
            })
            vim.g.gitgutter_sign_priority = 0

        end
    },
}
