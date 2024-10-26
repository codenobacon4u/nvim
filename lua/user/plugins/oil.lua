return {
    "stevearc/oil.nvim",
    --@module 'oil'
    --@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            columns = {
                "icon",
                "size",
                "mtime",
            },
            win_options = {
                signcolumn = "yes:2",
            },
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
