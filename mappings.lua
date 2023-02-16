---@type MappingsConfig
local M = {}

M.general = {
  n = {
    ["<C-`>"] = {
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle Terminal",
    },
    -- Better i, a
    -- Auto indent if you press i/a on empty line
    ["i"] = {
      function()
        local char_count = #vim.trim(vim.fn.getline("."))
        vim.api.nvim_feedkeys(char_count >= 1 and "i" or "S", "n", false)
      end
    },
    ["a"] = {
      function()
        local char_count = #vim.trim(vim.fn.getline("."))
        vim.api.nvim_feedkeys(char_count >= 1 and "a" or "S", "n", false)
      end
    },
    ["I"] = {
      function()
        local char_count = #vim.trim(vim.fn.getline("."))
        vim.api.nvim_feedkeys(char_count >= 1 and "I" or "S", "n", false)
      end
    },
    ["A"] = {
      function()
        local char_count = #vim.trim(vim.fn.getline("."))
        vim.api.nvim_feedkeys(char_count >= 1 and "A" or "S", "n", false)
      end
    },

    -- The keybinds below are also (Neo)Vim's keys, so you should uncomment 
    -- On your own to see if it interferes too much with your flow or not

    -- [";"] = { ":", "enter command mode", opts = { nowait = true } }, -- Default: Repeat [f,t,F,T]
    -- ["<C-b>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle Nvim Tree" }, -- Default: Jump one page down

    -- ["<C-c>"] = { '"+x', "Copy to Clipboard"}, -- Default: Interrupt current command/Abort pending command
    -- ["<C-v>"] = { '"+p', "Paste From Clipboard"}, -- Default: Enter Block-Visual Mode
    -- ["<C-x>"] = { '"+dd', "Cut Current Line to Clipboard" },
  },
  t = {
    ["<C-`>"] = { -- Mimicking vscode terminal toggling
      function()
        require("nvterm.terminal").toggle("horizontal")
      end,
      "Toggle Terminal",
    }
  },

  -- v = {
    -- These are Vim's keybinds too,
    -- So uncomment it if you feel it's okay 

    -- ["<C-c>"] = { '"+y', "Copy Selection", }, -- Default: Stop visual mode
    -- ["<C-v>"] = { '"+p', "Paste From Clipboard"} -- Default: Enter/Escape Block-visual mode
    -- ["<C-x>"] = { '"+d', "Cut Selection", } -- Default: Subtract highlighted text, :h v_CTRL-X
  -- },

  -- i = {
    -- ["<C-c>"] = { '<C-o>"+y', "Copy Selection", }, -- Default: Quit insert mode
    -- ["<C-v>"] = { '<C-o>"+p', "Paste From Clipboard"} -- Default: Insert literal keycode, recommend against uncommenting this, use <C-S-v> instead
    -- ["<C-x>"] = { '<C-o>"+dd', "Cut Selection", } -- Default: Subtract highlighted text, :h v_CTRL-X
  -- }
}


--- Replicating vscode commenting (well somewhat)
M.comment = {
  n = {
    ["<C-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },
  v = {
    ["<C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  }
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
    ["<F23>"] = { -- Shift-f11
      "<cmd>DapStepOut<CR>",
      "Step Out (Debug)"
    },
  }
}

M.lspconfig = {
  n = {
    ["<F12>"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "Goto Definition"
    },
    -- Shift-f12
    -- Open reference menu for word under cursor
    ["<F24>"] = { 
      function()
        require("lspsaga.finder"):lsp_finder()
      end
    },
    -- Open Almost vscode equivalent source action menu
    ["<leader>ca"] = {
      "<cmd>Lspsaga code_action<CR>",
      "Code Action",
    }
  },
  v = {
    ["<leader>ca"] = {
      "<cmd>Lspsaga code_action<CR>",
      "Code Action",
    }
  }
}

return M
