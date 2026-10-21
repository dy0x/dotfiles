local M = {}
local last_appearance
local pending = false
local stopped = false

function M.apply(appearance)
  require('theme-picker').apply {
    scheme = appearance == 'light' and 'dayfox' or 'gruvbox',
    background = appearance,
  }
end

function M.setup()
  if vim.fn.has('macunix') ~= 1 then
    M.apply(vim.o.background)
    return
  end

  local function appearance(result)
    return result.code == 0 and vim.trim(result.stdout) == 'Dark' and 'dark' or 'light'
  end

  local command = { 'defaults', 'read', '-g', 'AppleInterfaceStyle' }
  last_appearance = appearance(vim.system(command, { text = true }):wait())
  M.apply(last_appearance)

  local function check(force)
    if pending or stopped then return end
    pending = true
    vim.system(command, { text = true }, function(result)
      vim.schedule(function()
        pending = false
        if stopped then return end
        local current = appearance(result)
        if force or current ~= last_appearance then
          last_appearance = current
          M.apply(current)
        end
      end)
    end)
  end

  local timer = assert(vim.uv.new_timer())
  timer:start(3000, 3000, vim.schedule_wrap(function() check(false) end))
  local group = vim.api.nvim_create_augroup('system-theme', { clear = true })
  vim.api.nvim_create_autocmd('FocusGained', {
    group = group,
    callback = function() check(false) end,
  })
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = function()
      stopped = true
      timer:stop()
      timer:close()
    end,
  })
  vim.api.nvim_create_user_command('ThemeAuto', function() check(true) end, {
    desc = 'Restore the theme matching macOS appearance',
  })
end

return M
