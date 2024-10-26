vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

vim.keymap.set("n", "U", "<C-r>")

vim.keymap.set({ "s", "i", "n", "v" }, "<C-s>", "<esc>:w<cr>")

vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-;>", "<C-w>;")

vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>tab split<cr>")
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>")

vim.keymap.set("t", "<leader><esc>", "<C-\\><C-N>")

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

-- Floating terminal.
vim.keymap.set('n', '<M-t>', function()
    local cwd = vim.fn.expand '%:p:h'
    ---@cast cwd string
    if vim.startswith(cwd, 'term') then
        vim.cmd 'close'
    else
        require('user.core.float_term').float_term(nil, { cwd = cwd })
    end
end, { desc = 'Toggle terminal' })
vim.keymap.set('n', '<M-T>', function()
    require('user.core.float_term').float_term(nil, {})
end, { desc = 'Open terminal (root dir)' })
vim.keymap.set('t', '<M-t>', '<cmd>close<cr>', { desc = 'Close terminal' })
