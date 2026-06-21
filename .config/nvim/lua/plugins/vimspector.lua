return {
    {
        "puremourning/vimspector",
        lazy = true,
        config = function()
            local keyset = vim.api.nvim_set_keymap
            -- vim.g.vimspector_enable_mappings = "HUMAN"
            vim.g.vimspector_install_gadgets = {
                "debugpy", "vscode-cpptools", "CodeLLDB", "vscode-java-debug", "vscode-java-language-server"
            }

            vim.g.vimscpector_sign_priority = {
                vimspectorBP =              99997,
                vimspectorBPCond =          99997,
                vimspectorBPLog =           99997,
                vimspectorBPDisabled =      99997,
                vimspectorPC =              99998,
                vimspectorPCBP =            99999,
                vimspectorCurrentThread =   99997,
                vimspectorCurrentFrame =    99997
            }

            keyset("n", "<F2>", ":VimspectorReset<CR>", {noremap = true})
            keyset("n", "<F3>", "<Plug>VimspectorStop", {noremap = true})
            keyset("n", "<F4>", "<Plug>VimspectorRestart", {noremap = true})
            keyset("n", "<F5>", "<Plug>VimspectorContinue", {noremap = true})
            keyset("n", "<F6>", "<Plug>VimspectorPause", {noremap = true})
            keyset("n", "<F8>", "<Plug>VimspectorAddFunctionBreakpoint", {noremap = true})
            keyset("n", "<F9>", "<Plug>VimspectorToggleBreakpoint", {noremap = true})
            keyset("n", "<leader><F9>", "<Plug>VimspectorDisassemble", {noremap = true})
            keyset("n", "<F10>", "<Plug>VimspectorStepOver", {noremap = true})
            keyset("n", "<F11>", "<Plug>VimspectorStepInto", {noremap = true})
            keyset("n", "<F12>", "<Plug>VimspectorStepOut", {noremap = true})

            keyset("n", "<leader>di", "<Plug>VimspectorBalloonEval", {})
        end
    },
}
