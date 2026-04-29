if vim.fn.filereadable(vim.env.HOME .. "/.config/lightmode") == 1 then
  return {
    {
      "maxmx03/solarized.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function(_, opts)
        vim.o.termguicolors = true
        vim.o.background = "light"
        require("solarized").setup(opts)
        vim.cmd.colorscheme("solarized")
      end,
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "solarized",
      },
    },
  }
else
  return {
    { "Mofiqul/dracula.nvim" },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "dracula",
      },
    },
  }
end
