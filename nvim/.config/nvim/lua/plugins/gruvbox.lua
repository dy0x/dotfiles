return {{
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- make sure it loads before other plugins
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('gruvbox').setup {
            -- you can define your preferred options here
            contrast = 'hard',
            transparent_mode = false
        }
        vim.cmd.colorscheme 'gruvbox'
    end
}}
-- vim: ts=2 sts=2 sw=2 et