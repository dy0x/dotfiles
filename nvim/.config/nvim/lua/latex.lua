-- Compile in the source directory so relative inputs and PDF paths work.
local function source()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' or vim.fn.fnamemodify(path, ':e') ~= 'tex' then
    vim.notify('Open a saved .tex file first', vim.log.levels.WARN)
    return
  end
  return path
end

local function view(path)
  local pdf = vim.fn.fnamemodify(path, ':r') .. '.pdf'
  if vim.fn.filereadable(pdf) == 0 then
    vim.notify('Compile the document first: ' .. pdf, vim.log.levels.WARN)
    return
  end
  vim.fn.jobstart({ 'open', pdf }, { detach = true })
end

local function compile(show)
  local path = source()
  if not path then return end
  if vim.fn.executable('pdflatex') == 0 then
    vim.notify('pdflatex is not on Neovim’s PATH', vim.log.levels.ERROR)
    return
  end
  vim.cmd.write()
  local dir = vim.fn.shellescape(vim.fn.fnamemodify(path, ':h'))
  local file = vim.fn.shellescape(vim.fn.fnamemodify(path, ':t'))
  vim.cmd('!cd ' .. dir .. ' && pdflatex -interaction=nonstopmode -halt-on-error -synctex=1 ' .. file)
  if vim.v.shell_error == 0 and show then view(path) end
end

vim.api.nvim_create_user_command('LatexCompile', function() compile(false) end, {})
vim.api.nvim_create_user_command('LatexBuild', function() compile(true) end, {})
vim.api.nvim_create_user_command('LatexView', function()
  local path = source()
  if path then view(path) end
end, {})
vim.keymap.set('n', '<leader>c', '<cmd>LatexCompile<CR>', { desc = 'Compile LaTeX' })
vim.keymap.set('n', '<leader>p', '<cmd>LatexView<CR>', { desc = 'Preview LaTeX PDF' })
