return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = vim.fn.filereadable(vim.env.HOME .. "/.config/lightmode")
                == 1
              and "solarized"
            or "dracula-nvim",
        },
      }
    end,
  },
}
