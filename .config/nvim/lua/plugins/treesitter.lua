return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"solidity",
			"vim",
			"vimdoc",
			"yaml",
		},
		auto_install = true,
		-- ignore_install = { "javascript" },

		highlight = {
			enable = true,
			-- disable = { "c", "rust" },
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
	},

	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup(opts)
	end,
}
