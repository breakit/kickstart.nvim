vim.filetype.add {
  extension = {
    p = 'abl',
    w = 'abl',
    cls = 'abl',
    i = 'abl',
  },
}

local custom_parser_setup = {
  install_info = {
    url = 'https://github.com/usagi-coffee/tree-sitter-abl',
    files = { 'src/parser.c' },
  },
  filetype = 'abl',
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and parsers and type(parsers.get_parser_configs) == "function" then
      local configs = parsers.get_parser_configs()
      if configs then
        configs.abl = custom_parser_setup
      end
    end
  end,
})

