-- Define the FoldText function in the global scope (ripped from my .vimrc)
function _G.FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local sub = line:gsub('" .{{[ ]*', "")
  local nlines = vim.v.foldend - vim.v.foldstart
  local indent = string.rep(" ", 2 * (vim.v.foldlevel - 1))
  local text = string.format("%s📝 [ %s ] (%d lines) ", indent, sub, nlines)
  return text .. string.rep(" ", vim.o.columns)
end

-- Set the foldtext option to use our custom function
vim.opt.foldtext = "v:lua.FoldText()"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "*{{,}}*"
