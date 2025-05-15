vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

--Navigate vim panels betters
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
--Navigate between buffers
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
-- Add this keymap wherever you define your general keymaps
vim.keymap.set({ "n", "v" }, "<leader>gf", function()
  -- Use BufFormattingSync for synchronous formatting
  require("conform").formattingsync()
  -- Or BufFormattingAsync for asynchronous (less blocking)
  -- require("conform").formattingasync()
end, { desc = "Format file" })
