local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- VsCode-like popup menu
-- Taken from Usuim/Usuim
vim.cmd([[
  aunmenu PopUp
  anoremenu PopUp.Go\ To\ Definition                  <cmd>lua vim.lsp.buf.definition()<CR>
  anoremenu PopUp.Go\ To\ Type\ Definition            <cmd>lua vim.lsp.buf.type_definition()<CR>
  anoremenu PopUp.Go\ To\ Implementations             <cmd>lua vim.lsp.buf.implementation()<CR>
  anoremenu PopUp.Go\ To\ References                  <cmd>lua vim.lsp.buf.references()<CR>
  nnoremenu PopUp.Code\ Actions                       <cmd>Lspsaga code_action<CR>
  vnoremenu PopUp.Code\ Actions                       <cmd>Lspsaga code_action<CR>
  anoremenu PopUp.-1-                                 <Nop>

  anoremenu PopUp.Rename\ Occurence\ Under\ Cursor    <cmd>Lspsaga rename<CR>
  anoremenu PopUp.Rename\ Occurence\ In\ Project      <cmd>Lspsaga rename ++project<CR>
  anoremenu PopUp.-2-                                 <Nop>

  inoremenu PopUp.Cut         <C-o>"+dd
  nnoremenu PopUp.Cut         "+dd
  vnoremenu PopUp.Cut         "+d
  inoremenu PopUp.Copy        "+y
  nnoremenu PopUp.Copy        "+y
  vnoremenu PopUp.Copy        "+y
  inoremenu PopUp.Paste       "+p
  nnoremenu PopUp.Paste       "+p
  vnoremenu PopUp.Paste       "+p
  anoremenu PopUp.-3-         <Nop>


]])

dofile(vim.g.base46_cache .. "statusline")

--- This is currently only for neovim nightly users
--- Loading this file will make your number column looks almost like vscode :)
--- Pre warning is that this may slow down the render time between each keystroke by a lot
--- Credits to https://github.com/CKolkey for the example implementation
--- and to @luukvbaal for the feature itself

-- vim.opt.fillchars = {
--   eob = " ",
--   foldopen = "",
--   foldclose = "",
-- }
-- vim.api.nvim_create_autocmd({"FileType"}, {
--   callback = function(args)
--     if vim.tbl_contains({
--       "nofile",
--       "help",
--       "prompt",
--       "terminal",
--       "quickfix",
--     }, vim.bo[args.buf].buftype)
--     or vim.tbl_contains({
--       "help",
--       "lspinfo",
--       "TelescopePrompt",
--       "TelescopeResults",
--       "mason",
--       "NvimTree"
--     }, vim.bo[args.buf].filetype) then
--       return
--     end
--     vim.wo.statuscolumn = "%{%v:lua.require('custom.plugins.statuscolumn').draw()%}"
--   end
-- })
