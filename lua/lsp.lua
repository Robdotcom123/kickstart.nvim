
-- ============================================================================
-- LSP 
-- ============================================================================

-- Function to find project root
local function find_root(patterns)
  local path = vim.fn.expand('%:p:h')
  local root = vim.fs.find(patterns, { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ':h') or path
end

-- Shell LSP setup
local function setup_shell_lsp()
  vim.lsp.start({
    name = 'bashls',
    cmd = {'bash-language-server', 'start'},
    filetypes = {'sh', 'bash', 'zsh'},
    root_dir = find_root({'.git', 'Makefile'}),
    settings = {
      bashIde = {
        globPattern = "*@(.sh|.inc|.bash|.command)"
      }
    }
  })
end


-- Python LSP setup
local function setup_python_lsp()
  vim.lsp.start({
    name = 'pylsp',
    cmd = {'pylsp'},
    filetypes = {'python'},
    root_dir = find_root({'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git'}),
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
              enabled = false
          },
          flake8 = {
              enabled = true,
          },
          black = {
              enabled = true
          }
        }
      }
    }
  })
end

-- lua lsp
vim.lsp.config['luals'] = {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}
vim.lsp.enable('luals')

-- Autocommands & Keymaps
--
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = bufnr }

    -- Nützliche LSP-Mappings
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Open floating hover window" })
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP rename" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code action" })
  end,
})

vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open floating Diagnostics window and focus it" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Goto previous Dagnostics entry" })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Goto next Diagnostics entry" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostics list window and focus it" })

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 } )
    if filetype == "vim.diagnostic" then
      vim.keymap.set("n", "<Esc>", ":q<CR>", { buffer = bufnr, silent = true })
    end
  end,
})
