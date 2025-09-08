-- ~/.config/nvim/lua/plugins/color-highlighter/init.lua

return {
  "color-highlighter",
  name = "color-highlighter",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/color-highlighter",
  virtual = true,
  opts = {},
  config = function()
    local M = {}
    local ns_id = vim.api.nvim_create_namespace("color-highlighter")
    local highlight_cache = {}

    -- Function to convert 3-digit hex to 6-digit hex and ensure '#' is present
    local function normalize_hex(hex)
      hex = hex:gsub("^#", "") -- Remove '#' if present
      if #hex == 3 then
        hex = hex:gsub(".", function(c)
          return c .. c
        end)
      end
      return "#" .. hex -- Ensure '#' is present
    end

    -- Function to create a valid highlight group name
    local function create_hl_group_name(hex)
      return "HexColor" .. hex:gsub("#", "")
    end

    -- Function to determine if a color is light or dark
    local function is_light(hex)
      hex = hex:gsub("^#", "") -- Remove '#' for calculation

      if #hex ~= 6 then
        return false
      end

      local r, g, b =
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16)

      if not r or not g or not b then
        return false
      end

      return (0.299 * r + 0.587 * g + 0.114 * b) / 255 > 0.5
    end

    -- Function to set highlight (with caching and error handling)
    local function set_highlight(hex)
      local normalized_hex = normalize_hex(hex)
      if highlight_cache[normalized_hex] then
        return highlight_cache[normalized_hex]
      end
      local hl_group = create_hl_group_name(normalized_hex)
      local fg_color = is_light(normalized_hex) and "#000000" or "#FFFFFF"
      local success, err = pcall(
        vim.api.nvim_set_hl,
        0,
        hl_group,
        { bg = normalized_hex, fg = fg_color }
      )
      if not success then
        vim.api.nvim_err_writeln(
          "Error setting highlight for " .. normalized_hex .. ": " .. err
        )
        return nil
      end
      highlight_cache[normalized_hex] = hl_group
      return hl_group
    end

    -- Function to find and highlight hex colors
    function M.highlight_hex_colors()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      for lnum, line in ipairs(lines) do
        for hex in line:gmatch("#[%da-fA-F]+") do
          if #hex == 4 or #hex == 7 then
            local hl_group = set_highlight(hex)
            if hl_group then
              local from_col, to_col = line:find(hex, 1, true)
              if from_col and to_col then
                vim.api.nvim_buf_add_highlight(
                  bufnr,
                  ns_id,
                  hl_group,
                  lnum - 1,
                  from_col - 1,
                  to_col
                )
              end
            end
          end
        end
      end
    end

    -- Debounce function (no new_timer in my build)
    -- local function debounce(fn, ms)
    --   local timer = vim.loop.new_timer()
    --   return function(...)
    --     local args = { ... }
    --     timer:start(ms, 0, function()
    --       timer:stop()
    --       vim.schedule(function()
    --         fn(unpack(args))
    --       end)
    --     end)
    --   end
    -- end

    -- Debounced highlight function - 400ms
    -- local highlight_debounced = debounce(M.highlight_hex_colors, 400)

    -- Set up autocommands
    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
      pattern = { "*" },
      callback = M.highlight_hex_colors,
    })

    -- Initial highlighting for the current buffer
    M.highlight_hex_colors()
  end,
}
