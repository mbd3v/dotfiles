-- Offer to create a pyproject.toml when a Python file is opened inside a
-- project that doesn't have one. The [tool.pyright] section points pyright at
-- the project's virtualenv so imports from installed packages resolve. If the
-- venv shows up after the pyproject.toml exists, offer to add that section.

local root_markers = {
    ".git", "requirements.txt", "setup.py", "setup.cfg", "Pipfile", ".venv", "venv",
}

-- Roots already asked about this session, so a "No" sticks until restart.
local asked_create = {}
local asked_pyright = {}

local function find_venv(root)
    for _, name in ipairs({ ".venv", "venv" }) do
        if vim.uv.fs_stat(root .. "/" .. name .. "/bin/python") then
            return name
        end
    end
end

local function pyright_lines(venv)
    return {
        "",
        "[tool.pyright]",
        'venvPath = "."',
        string.format('venv = "%s"', venv),
    }
end

local function python_version(python)
    local result = vim.system({
        python, "-c", "import sys; print('%d.%d' % sys.version_info[:2])",
    }, { text = true }):wait()
    if result.code ~= 0 then return nil end
    return vim.trim(result.stdout)
end

local function write(path, lines, message)
    if vim.fn.writefile(lines, path) ~= 0 then
        vim.notify("Failed to write " .. path, vim.log.levels.ERROR)
        return
    end
    vim.notify(message)
    pcall(vim.cmd, "LspRestart pyright")
end

-- Deferred so the prompt doesn't block startup when nvim is launched with a
-- .py file.
local function confirm(prompt, on_yes)
    vim.schedule(function()
        vim.ui.select({ "Yes", "No" }, { prompt = prompt }, function(choice)
            if choice == "Yes" then on_yes() end
        end)
    end)
end

local function create_pyproject(root)
    local venv = find_venv(root)
    local python = venv and (root .. "/" .. venv .. "/bin/python") or "python3"
    local version = python_version(python)

    -- PEP 508 names allow letters, digits, '.', '_' and '-' only.
    local name = vim.fs.basename(root):gsub("[^%w._-]", "-")

    local lines = {
        "[project]",
        string.format('name = "%s"', name),
        'version = "0.1.0"',
    }
    if version then
        table.insert(lines, string.format('requires-python = ">=%s"', version))
    end
    table.insert(lines, "dependencies = []")
    if venv then
        vim.list_extend(lines, pyright_lines(venv))
    end

    local path = root .. "/pyproject.toml"
    write(path, lines, "Created " .. path)
end

local function has_pyright_section(path)
    for _, line in ipairs(vim.fn.readfile(path)) do
        if line:match("^%s*%[tool%.pyright%]") then return true end
    end
    return false
end

local function check(buf)
    if vim.bo[buf].buftype ~= "" or vim.bo[buf].filetype ~= "python" then return end

    local root = vim.fs.root(buf, "pyproject.toml")
    if root then
        if asked_pyright[root] then return end
        local venv = find_venv(root)
        local path = root .. "/pyproject.toml"
        if not venv or has_pyright_section(path) then return end
        asked_pyright[root] = true

        confirm("Found " .. venv .. ". Add [tool.pyright] to pyproject.toml?", function()
            local lines = vim.list_extend(vim.fn.readfile(path), pyright_lines(venv))
            write(path, lines, "Added [tool.pyright] to " .. path)
        end)
        return
    end

    root = vim.fs.root(buf, root_markers)
    if not root or asked_create[root] then return end
    asked_create[root] = true

    confirm("No pyproject.toml in " .. vim.fn.fnamemodify(root, ":~") .. ". Create one?", function()
        create_pyproject(root)
    end)
end

-- FocusGained catches a venv created in another terminal while the file was
-- already open.
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = vim.api.nvim_create_augroup("PyprojectToml", { clear = true }),
    callback = function(args)
        check(args.buf)
    end,
})
