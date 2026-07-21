vim.filetype.add {
  extension = {
    p = 'abl',
    w = 'abl',
    cls = 'abl',
    i = 'abl',
  },
}

local function register()
  require('nvim-treesitter.parsers').abl = {
    install_info = {
      url = 'https://github.com/usagi-coffee/tree-sitter-abl',
      files = { 'src/parser.c' },
      branch = 'master',
      queries = 'queries',
    },
    filetype = 'abl',
  }
end

register()
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = register,
})
