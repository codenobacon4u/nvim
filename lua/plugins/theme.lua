return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme catppuccin-mocha]])
	end,
	opts = {
		no_italic = true,
		term_colors = true,
		transparent_background = true,
		integrations = {
			dropbar = {
				enabled = true,
				color_mode = true,
			},
			fzf = true,
			gitsigns = true,
			indent_blankline = { enabled = true },
			mason = true,
			noice = true,
			telescope = {
				enabled = true,
				style = "nvchad",
			},
			which_key = true,
		},
	},
}
