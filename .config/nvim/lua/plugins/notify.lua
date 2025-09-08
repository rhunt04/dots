return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          stages = "static",
          render = "compact",
        },
      }
    end,
  },
}
