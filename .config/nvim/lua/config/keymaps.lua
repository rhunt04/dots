-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Save the shift key.
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")
vim.keymap.set("n", "<Space>", "za")

-- Call float custom function on moves.
vim.keymap.set("n", "<C-Up>", function()
  require("config.float").float("k")
end, { silent = true })
vim.keymap.set("n", "<C-Down>", function()
  require("config.float").float("j")
end, { silent = true })

-- C-r for replacing on visual selection.
vim.api.nvim_set_keymap(
  "v",
  "<C-r>",
  [[ "ry:%s/<C-r>r//gc<C-f>3h<C-c> ]],
  { noremap = true, silent = false }
)

-- Format.
vim.api.nvim_set_keymap(
  "n",
  "<leader>wp",
  "Vgw",
  { noremap = true, silent = false, desc = "Wrap the paragraph under cursor." }
)
