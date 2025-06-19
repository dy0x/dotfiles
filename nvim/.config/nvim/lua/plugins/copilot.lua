return {
  {
    'github/copilot.vim',
    lazy = false,

    config = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true

      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, replace_keycodes = false, desc = 'Copilot accept' })

      local function toggle_copilot()
        if vim.g.copilot_enabled then
          vim.cmd 'Copilot disable'
          vim.g.copilot_enabled = false
          vim.notify 'Copilot disabled'
        else
          vim.cmd 'Copilot enable'
          vim.g.copilot_enabled = true
          vim.notify 'Copilot enabled'
        end
      end

      vim.keymap.set('n', '<leader>cp', toggle_copilot, { silent = true, desc = 'Toggle Copilot' })
    end,
  },
}
