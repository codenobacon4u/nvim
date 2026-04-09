return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate | TSInstallAll",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    })
  end,
}
