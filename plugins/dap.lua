--- The link to the doc is your friend
--- The code below is an example implementation of the cpptools of the link below
--- https://github.com/mfussenegger/nvim-dap/wiki/Extensions
local dap = require("dap")
local repl = require("dap.repl")
local mason_path = vim.fn.stdpath("data") .. "/mason"

local load_vscode_launch_js = function()
  require("dap.ext.vscode").load_launchjs(nil, {
    cppdbg = { "c", "cpp" },
  })
end

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🐞", texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "" })

-- dap-repl settings
repl.commands = vim.tbl_deep_extend("force", repl.commands, {
  exit = { "exit", ".exit", ".bye" },
})

--- Example adapter with vscode cpptools
dap.adapter.cppdbg = {
  id = "cppdbg",
  type = "executable",
	command = mason_path .. "/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

--- Example config (launch.json equivalent) structure for cpptools
--- Requires you to compile the executable first
dap.configurations.cpp = {
  {
    name = "Launch Current File",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- :h input
      return vim.fn.input({
        prompt = "Path to executable: ",
        default = vim.fn.expand("%:r"),
        completion = "file",
      })
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      {
        description = "デバッグ開始",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  },
}
load_vscode_launch_js()
local load_launchjs = vim.api.nvim_create_augroup("LoadVsCodeLaunchJS", {})
--- If you cd into a directory to debug, chances are you will do some stuffs there, and those stuffs may contain specific .vscode/launch.json actions
--- So just check & load if there is any
vim.api.nvim_create_autocmd("DirChanged", {
  group = load_launchjs,
  callback = function()
    load_vscode_launch_js()
  end
})
