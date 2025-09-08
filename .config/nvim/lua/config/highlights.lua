-- Define the highlight group
vim.api.nvim_set_hl(0, "CColumn", { bg = "red", fg = "black" })

-- Add the match for lines longer than 80 characters
-- Tried to condense this... no luck.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "dashboard" then
      vim.fn.matchadd("CColumn", "\\%81v.", 100)
    end
  end,
})
