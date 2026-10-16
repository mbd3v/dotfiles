-- Auto-generate/refresh vhdl_ls.toml from a Quartus .qsf file.
-- Fully self-contained: parses the .qsf and writes the toml in Lua.
-- Supports per-library grouping via the -library option on VHDL_FILE lines.
-- Regenerates when the toml is missing or the .qsf is newer, and also
-- watches the .qsf for live changes during a session.

local M = {}

-- Track active watchers per-qsf so we don't start duplicates.
local watchers = {}

-- Parse VHDL_FILE assignments out of a .qsf and write vhdl_ls.toml.
-- Groups files by their -library option (default "work").
-- Returns true on success.
local function write_toml(root, qsf)
    local fd = io.open(qsf, "r")
    if not fd then return false end

    -- libs: { [libname] = { list of files }, ... }
    -- order: preserve first-seen library order for stable output
    local libs = {}
    local order = {}

    for line in fd:lines() do
        local path = line:match(
            'set_global_assignment%s+.-%-name%s+VHDL_FILE%s+(%S+)'
        )
        if path then
            path = path:gsub('"', "")

            -- Optional: -library <name> anywhere on the line.
            -- Handles both quoted and unquoted names.
            local lib = line:match('%-library%s+"([^"]+)"')
                or line:match('%-library%s+(%S+)')
                or "work"

            if not libs[lib] then
                libs[lib] = {}
                table.insert(order, lib)
            end
            table.insert(libs[lib], path)
        end
    end
    fd:close()

    local lines = { "[libraries]" }
    for _, lib in ipairs(order) do
        table.insert(lines, string.format("%s.files = [", lib))
        for _, f in ipairs(libs[lib]) do
            table.insert(lines, string.format('  "%s",', f))
        end
        table.insert(lines, "]")
    end
    table.insert(lines, "") -- trailing newline

    local toml = root .. "/vhdl_ls.toml"
    local out = io.open(toml, "w")
    if not out then return false end
    out:write(table.concat(lines, "\n"))
    out:close()
    return true
end

-- Regenerate the toml if needed, then restart the LSP so it re-reads it.
-- Returns true if a regeneration happened.
local function regenerate(root, qsf, force)
    local toml = root .. "/vhdl_ls.toml"
    local qsf_stat = vim.uv.fs_stat(qsf)
    if not qsf_stat then return false end

    local toml_stat = vim.uv.fs_stat(toml)
    local needs_update = force
        or (not toml_stat)
        or (qsf_stat.mtime.sec > toml_stat.mtime.sec)

    if not needs_update then return false end

    if write_toml(root, qsf) then
        vim.schedule(function()
            pcall(vim.cmd, "LspRestart vhdl_ls")
        end)
        return true
    end
    return false
end

-- Start a per-session fs_event watcher on the qsf (idempotent).
local function watch_qsf(root, qsf)
    if watchers[qsf] then return end

    local w = vim.uv.new_fs_event()
    if not w then return end
    watchers[qsf] = w

    w:start(qsf, {}, vim.schedule_wrap(function(err)
        if err then return end
        regenerate(root, qsf, true) -- force: qsf just changed
        -- Some editors replace files (rename) rather than write in place,
        -- which invalidates the watch. Re-arm it.
        w:stop()
        watchers[qsf] = nil
        watch_qsf(root, qsf)
    end))
end

local function setup(bufnr)
    vim.notify("vhdl_ls setup fired for buf " .. bufnr)
    --local root = vim.fs.root(bufnr, { "vhdl_ls.toml", "*.qsf", ".git" })
    local root = vim.fs.root(bufnr, function(name, _path)
    return name:match("%.qsf$") ~= nil
        or name == "vhdl_ls.toml"
        or name == ".git"
    end)
    if not root then return end

    local qsf = vim.fn.glob(root .. "/*.qsf")
    if qsf == "" then return end -- no Quartus project here
    qsf = vim.split(qsf, "\n")[1] -- first match if multiple

    regenerate(root, qsf, false) -- on-open: only if missing/stale
    watch_qsf(root, qsf)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "vhdl",
    callback = function(args)
        setup(args.buf)
    end,
})

return M
