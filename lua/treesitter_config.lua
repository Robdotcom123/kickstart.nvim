require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "lua",
    "python",
    "javascript",
    "clojure",
    "cmake",
    "cpp",
    "bash",
    "json",
    "latex",
    "bibtex",
    "llvm", },
  -- default values um warning zu behandeln
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  modules = {},
  -- ende

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

