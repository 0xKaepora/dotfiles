return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local colors = {
			black = "#1b1e28",
			white = "#e4f0fb",
			red = "#d0679d",
			green = "#5de4c7",
			blue = "#89ddff",
			yellow = "#fffac2",
			gray = "#a6accd",
			darkgray = "#767c9d",
			lightgray = "#506477",
			inactivegray = "#717cb4",
		}

		local tuxx = {
			normal = {
				a = { bg = colors.gray, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.blue },
				c = { bg = colors.black, fg = colors.white },
			},
			insert = {
				a = { bg = colors.blue, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.blue },
				c = { bg = colors.black, fg = colors.white },
			},
			visual = {
				a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.blue },
				c = { bg = colors.black, fg = colors.white },
			},
			replace = {
				a = { bg = colors.red, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.blue },
				c = { bg = colors.black, fg = colors.white },
			},
			command = {
				a = { bg = colors.green, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.blue },
				c = { bg = colors.black, fg = colors.white },
			},
			inactive = {
				a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
				b = { bg = colors.black, fg = colors.blue },
				c = { bg = colors.black, fg = colors.white },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = tuxx,
				component_separators = { left = "", right = "" },
				section_separators = { left = " ", right = " " },
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
