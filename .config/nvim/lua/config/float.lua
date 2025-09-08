local function escape_pattern(char)
  -- Escape special characters for Lua pattern matching
  return char:gsub("([%.%+%-%*%?%[%]%^%$%(%)])", "%%%1")
end

local function float(key)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_line_number = cursor_pos[1] -- Row (line number)
  local current_col = cursor_pos[2] -- Column (0-indexed)

  local myChar = vim.fn.strcharpart(
    vim.fn.getline(current_line_number):sub(current_col + 1),
    0,
    1
  )
  local escapedChar = escape_pattern(myChar)

  while true do
    local line = vim.fn.getline(current_line_number)

    -- Check if the cursor is within bounds and matches the character or is a space
    if
      #line < current_col + 1
      or line:sub(current_col + 1, current_col + 1):match(escapedChar)
      or line:sub(current_col + 1, current_col + 1):match("%s")
    then
      vim.cmd("normal! " .. key)

      -- Update cursor position after the action
      cursor_pos = vim.api.nvim_win_get_cursor(0)
      current_line_number = cursor_pos[1]
      current_col = cursor_pos[2]

      -- Check for top or bottom of the file
      if current_line_number == 1 then
        vim.api.nvim_echo(
          { { "⚠ Top of file: can't float higher!", "WarningMsg" } },
          false,
          {}
        )
        break
      elseif current_line_number == vim.fn.line("$") then
        vim.api.nvim_echo(
          { { "⚠ End of file: can't float lower!", "WarningMsg" } },
          false,
          {}
        )
        break
      end

      -- Get the fold status
      local fold_status = vim.fn.foldclosed(current_line_number)

      -- Ensure fold_status is treated as a number
      if fold_status ~= -1 then
        if tonumber(fold_status) > -1 then
          vim.api.nvim_echo(
            { { "⚐ Not going into a fold.", "WarningMsg" } },
            false,
            {}
          )
          break
        end
      end
    else
      break
    end
  end
end

return {
  float = float,
}
