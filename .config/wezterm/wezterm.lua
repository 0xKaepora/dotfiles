local wezterm = require("wezterm")
return {
	color_scheme = "Poimandres",
	font = wezterm.font("Berkeley Mono"),
	-- font = wezterm.font("FiraCode Nerd Font"),
	font_size = 11.0,
	cell_width = 1.0,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	front_end = "WebGpu",
}
