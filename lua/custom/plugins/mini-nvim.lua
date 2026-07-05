vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
})

-- 1. Enable mini.tabline
require('mini.tabline').setup({
  show_icons = true,
})

-- 2. Enable mini.bufdelete
require('mini.bufremove').setup({})

-- 3. Enable mini.completion
require('mini.completion').setup({})

-- 4. Enable mini.move
require('mini.move').setup({})

-- 5. Enable mini.splitjoin
require('mini.splitjoin').setup({})

-- 6. Enable mini.cmdline
require('mini.cmdline').setup({})

-- 7. Enable mini.trailspace
require('mini.trailspace').setup({})

-- 8. Enable mini.git
require('mini.git').setup()

-- 9. Enable mini.align
require('mini.align').setup({})

-- Add a shortcut to wipe the current buffer out of the tabline safely
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete(0, false) -- '0' targets the current buffer
end, { desc = 'Close current tab/buffer safely' })

-- Remap square brackets on german keyboard layout
-- Leader combinations to replace bracket plugins (like mini.bracketed or mini.jump)
vim.keymap.set({ 'n', 'v' }, 'ü', '[', { remap = true, desc = "Bracket Backwards [" })
vim.keymap.set({ 'n', 'v' }, '+', ']', { remap = true, desc = "Bracket Next ]" })
