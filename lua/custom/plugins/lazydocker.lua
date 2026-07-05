vim.pack.add({
  'https://github.com/crnvl96/lazydocker.nvim',
})

require('lazydocker').setup({
  -- optional, these are the defaults
  window = {
    settings = {
      width = 0.618,
      height = 0.618,
      border = 'rounded',
      relative = 'editor',
    },
  },
})

vim.keymap.set({ 'n', 't' }, '<leader>ld', function()
  require('lazydocker').toggle({ engine = 'docker' })
end, { desc = 'Toggle LazyDocker' })
