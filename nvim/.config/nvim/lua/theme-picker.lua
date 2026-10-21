local M = {}

M.themes = {
  { name = 'Solarized Light', scheme = 'solarized', background = 'light' },
  { name = 'Gruvbox Light', scheme = 'gruvbox', background = 'light' },
  { name = 'GitHub Light', scheme = 'github_light', background = 'light' },
  { name = 'PaperColor Light', scheme = 'PaperColor', background = 'light' },
  { name = 'Nord Light', scheme = 'nord-light', background = 'light' },
  { name = 'Rosé Pine Dawn (light)', scheme = 'rose-pine-dawn', background = 'light' },
  { name = 'vim-one Light', scheme = 'one', background = 'light' },
  { name = 'seoul256 Light', scheme = 'seoul256-light', background = 'light' },
  { name = 'Catppuccin Latte (light)', scheme = 'catppuccin-latte', background = 'light' },
  { name = 'Catppuccin Mocha (dark)', scheme = 'catppuccin-mocha', background = 'dark' },
  { name = 'Gruvbox Dark (your original)', scheme = 'gruvbox', background = 'dark' },
}

function M.apply(theme)
  if theme.scheme == 'gruvbox' then
    require('gruvbox').setup {
      contrast = 'hard',
      transparent_mode = theme.background == 'dark',
    }
  end
  vim.o.background = theme.background
  vim.cmd.colorscheme(theme.scheme)
end

function M.pick()
  vim.ui.select(M.themes, {
    prompt = 'Compare themes:',
    format_item = function(theme) return theme.name end,
  }, function(theme)
    if theme then M.apply(theme) end
  end)
end

vim.api.nvim_create_user_command('ThemePicker', M.pick, { desc = 'Compare installed colour themes' })
vim.keymap.set('n', '<leader>ut', M.pick, { desc = 'Choose colour theme' })

return M
