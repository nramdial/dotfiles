return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=None]])
		require("nvim-tree").setup({
			renderer = {
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
      },
      filters = {
				dotfiles = true,
			},
		})
	end,
}
