
-- ============================================================================
-- STATUSLINE
-- ============================================================================

-- Git branch function
local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return "  " .. branch .. " "
  end
  return ""
end

-- File type with icon TODO um cpp tex etc erweitern. key sollte dann in statusleiste stehen
local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = "[LUA]",
    python = "[PY]",
    javascript = "[JS]",
    html = "[HTML]",
    css = "[CSS]",
    json = "[JSON]",
    markdown = "[MD]",
    vim = "[VIM]",
    sh = "[SH]",
    cpp = "[C++]",
    tex = "[LaTeX]",
  }

  if ft == "" then
    return "  "
  end

  return (icons[ft] or ft)
end

-- LSP status
local function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    local names = {}
    for _, client in pairs(clients) do
      table.insert(names, client.name)
    end
    return "LSPs: " .. "[" .. table.concat(names, ", ") .. "]"
  end
  return "  NoLSP"
end

-- Funktion, die die LSP-Namen als String zurückgibt
local function lsp_names()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients > 0 then
    return ""
  end
  local names = {}
  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end
  return "[" .. table.concat(names, ", ") .. "]"
end


-- Word count for text files
local function word_count()
  local ft = vim.bo.filetype
  if ft == "markdown" or ft == "text" or ft == "tex" then
    local words = vim.fn.wordcount().words
    return "  " .. words .. " words "
  end
  return ""
end

-- File size
local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand('%'))
  if size < 0 then return "" end
  if size < 1024 then
    return size .. "B "
  elseif size < 1024 * 1024 then
    return string.format("%.1fK", size / 1024)
  else
    return string.format("%.1fM", size / 1024 / 1024)
  end
end

-- Mode indicators with icons
local function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",  -- Ctrl-V
    c = "COMMAND",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",  -- Ctrl-S
    R = "REPLACE",
    r = "REPLACE",
    ["!"] = "SHELL",
    t = "TERMINAL"
  }
  return modes[mode] or ("  " .. mode:upper())
end

-- update Statusline color for different modes
local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end


vim.api.nvim_set_hl(0, "StatusLineNormal", { fg = "#ffffff", bg = "#005f87" })
vim.api.nvim_set_hl(0, "StatusLineInsert", { fg = "#ffffff", bg = "#5f0000" })
vim.api.nvim_set_hl(0, "StatusLineVisual", { fg = "#000000", bg = "#ffd700" })
vim.api.nvim_set_hl(0, "StatusLineTerminal", { fg = "#000000", bg = "#EB5800" })

vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" then
      vim.api.nvim_set_hl(0, "StatusLine", { link = "StatusLineNormal" })
    elseif mode == "i" then
      vim.api.nvim_set_hl(0, "StatusLine", { link = "StatusLineInsert" })
    elseif mode == "v" or mode == "V" or mode == "\22" then -- \22 = <C-v>
      vim.api.nvim_set_hl(0, "StatusLine", { link = "StatusLineVisual" })
    elseif mode == "t" then
      vim.api.nvim_set_hl(0, "StatusLine", { link = "StatusLineTerminal" })
    else
      vim.api.nvim_set_hl(0, "StatusLine", { link = "StatusLineNormal" })
    end
  end,
})


_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size
_G.lsp_status = lsp_status
_G.update_mode_colors = update_mode_colors
_G.lsp_names = lsp_names

--vim.cmd([[
--  highlight StatusLineBold gui=bold cterm=bold
--]])

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    callback = function()
    vim.opt_local.statusline = table.concat {
      "  ",
      "%#StatusLineBold#",
      update_mode_colors(),
      "%{v:lua.mode_icon()}",
      "%#StatusLine#",
      " │ %f %h%m%r",
      "%{v:lua.git_branch()}",
      " │ ",
      "%{v:lua.file_type()}",
      " | ",
      "%{v:lua.file_size()}",
      " | ",
      "%{v:lua.lsp_status()}",
      " | ",
      "%{v:lua.lsp_names()}",
      "%=",                     -- Right-align everything after this
      "%l:%c  %P ",             -- Line:Column and Percentage
    }
    end
  })
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

  vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
    callback = function()
      vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
    end
  })
end

setup_dynamic_statusline()
