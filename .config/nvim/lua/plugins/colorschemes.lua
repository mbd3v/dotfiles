return {
    {
        "tanvirtin/monokai.nvim",
        lazy = true,
        priority = 1000,

    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
    },
    {
       "navarasu/onedark.nvim",
        lazy = true,
        opts = {}
    },
    {
        "polirritmico/monokai-nightasty.nvim",
        lazy = true,
    },
    {
        "uhs-robert/oasis.nvim",
        lazy = true,
        config = function()
            require("oasis").setup()      -- (see Configuration below for all customization options)
            vim.o.background = "light"
        end
    },
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        init = function()
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            vim.g.sonokai_better_performance = 0
        end,
        config = function()
            -- Load Colorscheme here
            vim.cmd.colorscheme("sonokai") -- default colorscheme
        end
    }
}
