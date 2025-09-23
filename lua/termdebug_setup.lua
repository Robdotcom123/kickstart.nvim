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
