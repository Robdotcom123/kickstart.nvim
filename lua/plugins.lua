local plugin_path = vim.fn.stdpath("config") .. "/plugins/"
local plugins = {
  -- ich möchte soweit es geht auf tolle plugins verzichten, solange ich noch neovim noob bin
  { name = "nvim-treesitter", repo = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
  { name = "nvim-dap", repo = "https://github.com/mfussenegger/nvim-dap.git" },
  { name = "nvim-nio", repo = "https://github.com/nvim-neotest/nvim-nio" },
  { name = "nvim-dap-ui", repo = "https://github.com/rcarriga/nvim-dap-ui.git" },
}

local function install_plugins_if_missing()
  for _,p in ipairs(plugins) do
    local path = plugin_path .. p.name
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
      print("Installing plugin: " .. p.name)
      vim.fn.system({ "git", "clone", "--depth", "1", p.repo, path })
    end
  end
end

if vim.fn.executable("git") == 1 then
  install_plugins_if_missing()
end

local function add_plugin(name)
  vim.opt.rtp:append(plugin_path .. name)
end

local plugin_names = {}
for _, p in ipairs(plugins) do
  table.insert(plugin_names, p.name)
end
print(string.format("Loading plugins: %s", table.concat(plugin_names, ", ")))
add_plugin("nvim-treesitter")
add_plugin("nvim-dap")
add_plugin("nvim-nio")
add_plugin("nvim-dap-ui")
