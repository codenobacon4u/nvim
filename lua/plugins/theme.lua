return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function ()
        vim.cmd([[colorscheme catppuccin-mocha]])
    end,
    opts = {
        no_italic = true,
        term_colors = true,
        transparent_background = false,
        integrations = {
            telescope = {
                enabled = true,
                style = "nvchad",
            },
            dropbar = {
                enabled = true,
                color_mode = true,
            },
        },
    },
}
