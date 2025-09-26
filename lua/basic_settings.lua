vim.g.have_nerd_font = true


-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- Visual settings
vim.o.termguicolors = true
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.colorcolumn = '100'
vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.cmdheight = 1


-- File handling
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.updatetime = 300
vim.o.timeoutlen = 1500
vim.o.ttimeoutlen = 0
vim.o.autoread = true
vim.o.autowrite = false


-- Behaviour settings
vim.o.hidden = true
vim.o.errorbells = false
vim.o.backspace = "indent,eol,start"
vim.o.autochdir = false
vim.opt.path:append("**")
vim.o.selection = "exclusive"
vim.o.modifiable = true
vim.o.encoding = "UTF-8"

-- split behaviour
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on

-- Minimal number of screen lines to keep above and below the cursor.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
