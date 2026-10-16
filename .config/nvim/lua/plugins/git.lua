return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require('gitsigns').setup {
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = true,
                    virt_text_priority = 100,
                    use_focus = true,
                },

            }
        end,
        keys ={
            {
                "<leader>hs",
                ":Gitsigns stage_hunk<CR>",
                mode = { "n" },
                noremap = true,
                desc = "Stage/unstage git hunks"
            },
            {
                "<leader>hr",
                ":Gitsigns reset_hunk<CR>",
                mode = { "n" },
                noremap = true,
                desc = "Reset git hunk"
            },
            {
                "<leader>hp",
                ":Gitsigns preview_hunk_inline<CR>",
                mode = { "n" },
                noremap = true,
                desc = "Preview git hunk inline"
            },
            {
                "<leader>tb",
                ":Gitsigns toggle_current_line_blame<CR>",
                mode = { "n" },
                noremap = true,
                desc = "Toggle current libe blame"
            },
        }
    }
}
