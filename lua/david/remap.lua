-- move visual block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- append next line to end of line
vim.keymap.set("n", "J", "mzJ`z")
-- half page jump with cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- search keeps cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- better paste with <leader>p
vim.keymap.set("x", "<leader>p", [["_dP]])
-- yank to sys clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- we dont need Q
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q", "<nop>")
-- rename hover word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

