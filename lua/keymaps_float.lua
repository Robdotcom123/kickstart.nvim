

local function get_keymaps(bufnr, mode)
  local bufnr = bufnr or 0
  print("Keymaps for buffer: " .. bufnr)
  local modes = {n= 'Normal', i = 'Insert', v = 'Visual'}

  local result = {}
  for mode, text in pairs(modes) do
    table.insert(result, "========== MODUS " .. text)
    local keymaps = vim.api.nvim_get_keymap(mode)

    for _, map in ipairs(keymaps) do
      table.insert(result, string.format("%s -> %s               ----- %s", map.lhs, map.rhs or '<lua>', map.desc))
    end
  end
  return result
end


local function show_floating(lines, title)
  title = title or "Keymaps"

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(20, vim.o.lines - 4)
  local row = (vim.o.lines - height) / 2 - 1
  local col = (vim.o.columns - width) / 2


  --test 
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }
  vim.api.nvim_open_win(buf, true, opts)

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end

local function show(bufnr, mode)
  local lines = get_keymaps(bufnr, mode)
  if #lines == 0 then
    lines = { "Keine Keymaps gefunden für Modus: " .. mode }
  end
  show_floating(lines, "Keymaps (" .. mode .. ")")
end

vim.keymap.set("n", "<leader>km", function()
  show(0, "n")
end, { noremap = true, silent = true })
