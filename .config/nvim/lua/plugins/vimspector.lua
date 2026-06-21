return {
    {
        "puremourning/vimspector",
        config = function()
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

        end,
        keys = {
            {
                "<F2>",
                ":VimspectorReset<CR>",
                mode = "n",
                noremap = true,
                desc = "Reset debugger."
            },
            {
                "<F3>",
                "<Plug>VimspectorStop",
                mode = "n",
                noremap = true,
                desc = "Stop debugging."
            },
            {
                "<F4>",
                "<Plug>VimspectorRestart",
                mode = "n",
                noremap = true,
                desc = "Restart debugger."
            },
            {
                "<F5>",
                "<Plug>VimspectorContinue",
                mode = "n",
                noremap = true,
                desc = "Start/Continue debugging."
            },
            {
                "<F6>",
                "<Plug>VimspectorPause",
                mode = "n",
                noremap = true,
                desc = "Pause debugger."
            },
            {
                "<F8>",
                "<Plug>VimspectorAddFunctionBreakpoint",
                mode = "n",
                noremap = true,
                desc = "Add a *function* breakpoint for the expression."
            },
            {
                "<F9>",
                "<Plug>VimspectorToggleBreakpoint",
                mode = "n",
                noremap = true,
                desc = "Toggle _line_ breakpoint or log point on the current line."
            },
            {
                "<leader><F9>",
                "<Plug>VimspectorDisassemble",
                mode = "n",
                noremap = true,
                desc = "Show disassembly."
            },
            {
                "<F10>",
                "<Plug>VimspectorStepOver",
                mode = "n",
                noremap = true,
                desc = "Debugger step over."
            },
            {
                "<F11>",
                "<Plug>VimspectorStepInto",
                mode = "n",
                noremap = true,
                desc = "Debugger step into."
            },
            {
                "<F12>",
                "<Plug>VimspectorStepOut",
                mode = "n",
                noremap = true,
                desc = "Debugger step out."
            },
            {
                "<leader>di",
                "<Plug>VimspectorBalloonEval",
                mode = "n",
                desc = "Debugger show balloon eval."
            },
        }
    },
}
