local is_nvim_012 = vim.fn.has("nvim-0.12") == 1

local ensure_installed = {
  "cmake",
  "python",
  "cpp",
  "java",
  "javascript",
  "css",
  "c",
  "jsdoc",
  "make",
  "markdown",
  "html",
  "typescript",
  "tsx",
  "ruby",
  "rust",
  "vim",
  "bash",
  "c_sharp",
  "scss",
  "lua",
  "r",
  "json",
  "json5",
  "jsonc",
  "http",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "glsl",
  "gitignore",
  "git_config",
  "gitcommit",
  "git_rebase",
  "doxygen",
  "comment",
  "angular",
  "astro",
  "awk",
  "cuda",
  "dart",
  "dockerfile",
  "kotlin",
  "luadoc",
  "nim",
  "nix",
  "ocaml",
  "proto",
  "sql",
  "ssh_config",
  "vue",
  "wgsl",
  "wgsl_bevy",
  "xml",
  "yaml",
  "zig",
  "svelte",
  "bibtex",
  "graphql",
  "toml",
}

local legacy_spec = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_installed,
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
      })
    end,
  },
}

local main_spec = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      local already_installed =
        require("nvim-treesitter.config").get_installed()

      local parsers_to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      require("nvim-treesitter").install(parsers_to_install)
    end,
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
    end,
  },
}

return is_nvim_012 and main_spec or legacy_spec
