---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.twilight = {
  n = {
    ["<leader>tw"] = { "<cmd>Twilight<cr>", "toggle twilight" },
  },
}

-- more keybinds!

return M
