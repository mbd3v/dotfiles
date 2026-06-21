local general_installed_lsps = {
    "lua_ls", "rust_analyzer", "clangd",
    "pyright", "gopls", "ts_ls", "zls", "vimls", "vue_ls",
    "glsl_analyzer", "rnix", "jdtls",
    "omnisharp", "bashls", "ansiblels", "r_language_server", "svelte",
    "texlab"
}

local is_nvim_011 = vim.fn.has('nvim-0.11') == 1

return {
    {
        "mason-org/mason.nvim",
        lazy = true,
        tag = not is_nvim_011 and "v1.11.0" or nil,
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded"
                },
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                }
            })
            local registry = require("mason-registry")
            registry.refresh()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        tag = not is_nvim_011 and "v1.32.0" or nil,
        config = function()
            if is_nvim_011 then
                require("mason-lspconfig").setup({
                    ensure_installed = general_installed_lsps,
                    automatic_enable = true,
                })
            else
                require("mason-lspconfig").setup()
            end
        end
    },
    {
        -- used for installing non standard mason registry LSPs (e.g. linters, LSPs from alternate registries)
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = true,
        --enabled = not is_nvim_011,
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                "roslyn"
                    },
                run_on_start = true,
            })
        end
    }
}
