---- theme & transparency
vim.cmd.colorscheme("unokai")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none"})

-- import basic settings
require("basic_settings")

-- import basic keymaps
require("keymaps")

-- Basic autocommands
require("autocommands")

-- advanced settings
require("advanced_settings")

-- floating terminal
require ("float_terminal")

-- tab Leiste
require("tabs")

-- statusleiste
require("statusline")

-- lsp_config
require("lsp")
