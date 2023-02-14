---@type MappingsConfig
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- more keybinds!

--- Keybinds for nvim-dap that mimics VsCode debug keybinds
M.dap = {
  n = {
    ["<F5>"] = {
      "<cmd>DapContinue<CR>", "Start/Continue a debug session"
    },
    ["<F17>"] = { -- Keycode for Shift-f5
      "<cmd>DapTerminate<CR>",
      "Terminate/Stop a debug session"
    },
    ["<F6>"] = {
      function()
        require("dap").pause()
      end,
      "Pause a debug session"
    },
    ["<F9>"] = {
      "<cmd>DapToggleBreakpoint<CR>",
      "Toggle Breakpoint on Current Line"
    },
    ["<F10>"] = {
      "<cmd>DapStepOver<CR>",
      "Step Over (Debug session)",
    },
    ["<F11>"] = {
      "<cmd>DapStepInto<CR>", "Step Into (Debug)"
    },
    ["<F23>"] = {
      "<cmd>DapStepOut<CR>",
      "Step Out (Debug)"
    },
  }
}

return M
