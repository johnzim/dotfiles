-- Debugging helper function for Python and JavaScript/TypeScript
jl_comment = function()
  local filetype = vim.bo.filetype
  local word = vim.fn.expand('<cword>')
  local line = vim.fn.getline('.')
  local cursor_pos = vim.fn.col('.')
  local left_part = line:sub(1, cursor_pos):match("[_%w%.]+$")
  local right_part = line:sub(cursor_pos + 1):match("^[_%w%.]*")
  local full_word = left_part .. right_part
  local indent = vim.fn.indent('.')
  local indent_str = string.rep(" ", indent)
  local debug_statement = ""

  if filetype == "python" then
    debug_statement = indent_str .. "print(f'".. full_word .. " is {".. full_word.. "}')"
  elseif filetype == "typescript" or filetype == "javascript" or filetype == "typescriptreact" then
    debug_statement = indent_str .. "console.log('".. full_word .. " is', ".. full_word.. ");"
  end

  if debug_statement ~= "" then
    vim.api.nvim_put({debug_statement}, 'l', true, true)
    return
  end
  print("Unrecognized file type!")
end

-- Custom Telescope functions
find_files_no_test = function()
  require('telescope.builtin').find_files({
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob', '!**tests**',
    },
  })
end

find_text_no_test = function()
  require('telescope.builtin').live_grep({
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob', '!**/tests/**',
    },
  })
end

-- Function to reload Neovim configuration
function ReloadConfig()
    -- Unload all Lua modules related to your config
    for name, _ in pairs(package.loaded) do
        if name:match('^custom') or name == 'plugins' then
            package.loaded[name] = nil
        end
    end

    -- Source your init.vim
    vim.cmd('source $MYVIMRC')

    -- Optionally, print a message indicating that the configuration was reloaded
    print("Configuration reloaded!")
end

function DeleteBufferAndKeepSplit()
  local buf_num = vim.fn.bufnr('#') -- Get the previous buffer number
  local is_horizontal = vim.api.nvim_win_get_width(0) == vim.o.columns -- Check if the current split is horizontal

  -- If the previous buffer exists and is listed, switch to it
  if buf_num > 0 and vim.fn.buflisted(buf_num) == 1 then
    vim.cmd('b#')
    vim.cmd('bd#')
  else
    vim.cmd('bd')
    if is_horizontal then
      vim.cmd('split')
    else
      vim.cmd('vsplit')
    end
  end
end


YarnEslint = function()
  local file = vim.fn.expand('%')  -- Get the current file name
  local cmd = 'yarn eslint ' .. file  -- Build the command
  print('Running:', cmd)  -- Debugging: Print the command being run
  local output = vim.fn.system(cmd)  -- Run the command and capture the output
  print(output)  -- Print the output for debugging
  if vim.v.shell_error ~= 0 then  -- Check if the command failed
    print('ESLint failed with error:', vim.v.shell_error)
  else
    print('Linting complete for ' .. file)  -- Success message
  end
end

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })


function AddNextFlag()
    -- Get all lines in the current buffer
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- Initialize the maximum flag number
    local max_flag = 0

    -- Search for the highest FLAG number in the document
    for _, line in ipairs(lines) do
        local flag_num = line:match('FLAG (%d+)')
        if flag_num then
            max_flag = math.max(max_flag, tonumber(flag_num))
        end
    end

    -- Increment the flag number
    local next_flag = max_flag + 1

    -- Get the current cursor position
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

    -- Insert the new line below the current line
    vim.api.nvim_buf_set_lines(0, row, row, false, { string.format('print(f"FLAG %d")', next_flag) })
end
