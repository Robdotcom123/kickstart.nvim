
-- c++ debug config
-- vim.cmd 'packadd termdebug'

vim.g.termdebug_wide = 1

vim.keymap.set('n', '<leader>dd', ':Termdebug<CR>', { desc = 'Start Termdebug' })
vim.keymap.set('n', '<leader>db', ':Break<CR>', { desc = 'Set Breakpoint' })
vim.keymap.set('n', '<leader>dB', ':Clear<CR>', { desc = 'Clear Breakpoint' })
vim.keymap.set('n', '<leader>dr', ':Run<CR>', { desc = 'Run Program' })
vim.keymap.set('n', '<leader>dc', ':Continue<CR>', { desc = 'Continue Execution' })
vim.keymap.set('n', '<leader>ds', ':Step<CR>', { desc = 'Step Into' })
vim.keymap.set('n', '<leader>do', ':Over<CR>', { desc = 'Step Over' })
vim.keymap.set('n', '<leader>df', ':Finish<CR>', { desc = 'Finish Function' })

print(pcall(function()
  local dap = require("dap")
  local dapui = require("dapui")
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
  }

  dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb"
  }
  
  dap.configurations.cpp = {
    {
  name = "Launch",
  type = "lldb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
    },
  }
  dap.configurations.c = dap.configurations.cpp

  vim.keymap.set("n", "<F5>", function() require('dap').continue() end, { desc = "Continoue running program execution" })
  vim.keymap.set("n", "<F10>", function() require('dap').step_over() end, { desc = "Debug Step over Function under cursor" })
  vim.keymap.set("n", "<F11>", function() require('dap').step_into() end, { desc = "Debug Step into Function under cursor" })
  vim.keymap.set("n", "<F12>", function() require('dap').step_out() end, {desc = "Debug Step out of current function" })
  vim.keymap.set("n", "<leader>b", function() require('dap').toggle_breakpoint() end, { desc = "Set/Unset Breakpoint on current line" })
  vim.keymap.set("n", "<leader>B", function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Set Conditional Breakpoint" })
  vim.keymap.set("n", "<leader>du", function() require('dapui').toggle() end, { desc = "Toggle DapUi" })
  
end))
--]]

