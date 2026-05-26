-- If using with neovim and this vimrc is not being used, check to make sure 
-- your init.vim file exists (~/.config/nvim/init.vim) and points to this file 
-- as source.
--
-- Current Custom Key Binds:
--
-- <leader> = ;
--
-- <CR>                 Command Completion
-- gd                   Go to Definition
-- gy                   Go to type definition
-- gi                   Go to implementation
-- gr                   Go to references
-- <leader>rn           Rename variable
-- K                    Shows documentation for function/var/type/whatever is
--                            under your cursor in a nice little popup window. Note
--                            hat the K key mapping is Shift-k if that wasn't clear.
-- <leader>rn           Performs a rename of a variable much like you would
--                            expect from an IDE (renames a variable/function in all 
--                            occurrunces)
--
-- <F2>                 (Vimspector) Quit Debugging (VimspectorReset)
-- <F3>                 (Vimspector) Stop Debugging (VimspectorStop)
-- <F4>                 (Vimspector) Restart Debugging with same configuration
-- <F5>                 (Vimspector) Start/Continue Debugging
-- <F6>                 (Vimspector) Pause Debugger
-- <F8>                 (Vimspector) Add a *function* breakpoint for the expression
--                                   under the cursor
-- <F9>                 (Vimspector) Toggle _line_ breakpoint or logpoint on the current
--                                   line
-- <leader><F9>         (Vimspector) Show dissassembly
-- <F10>                (Vimspector) Step Over
-- <F11>                (Vimspector) Step Into
-- <F12>                (Vimspector) Step Out
-- <leader>di           (Vimspector) Balloon Eval
--
-- <leader>n            (Neotree) Toggles the file tree
--
-- <leader>ff           Using telescope, fuzzy find files
-- <leader>fg           Using telescope and ripgrep, fuzzy grep find text in files
-- <leader>fb           Using telescope, fuzzy find open buffers
-- 
-- <leader>tb           (Vista) Toggles the Tagbar in the right sidebar
--
-- <leader>tt           (Todo-comments) Using Telescope, search through todos
-- <leader>lt           (Todo-comments) Using Telescope, search through todos
--
-- <leader>nd           (Neogen) Allows the creation of automated documentation for
--                        code. (only works in some languages)
--
-- <leader>cc           Comment out line(s)
-- <leader>cu           Uncomment line(s)
--


require("options")

-- bootstrap lazyvim
-- Note that lazyvim stores all files in: ~/.local/share/nvim/lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
       "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    vim.fn.system(
    "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash"
    )
end
vim.opt.rtp:prepend(lazypath)

local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
end



-- Options for Lazy nvim
local lazy_opts = {
    ui = {
        border = "double",
        size = {
            width = 0.8,
            height = 0.8
        }
    }
}

require("lazy").setup("plugins", lazy_opts)


