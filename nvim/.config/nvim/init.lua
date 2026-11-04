vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'options'
require 'keymaps'
require 'latex'
require 'lazy-bootstrap'
require 'lazy-plugins'
require 'theme-picker'
require('theme-auto').setup()
