{pkgs, unstable, config, inputs, ...} :
	let
		colors = config.lib.stylix.colors;
	in
	{


	home.packages = [
		unstable.spotify-player
	];

	xdg.configFile."spotify-player/app.toml".source = ./app.toml;
	xdg.configFile."spotify-player/keymap.toml".source = ./keymap.toml;
	xdg.configFile."spotify-player/theme.toml".text = ''
		[[themes]]
		name = "stylix"
		[themes.palette]
		background = "#${colors.base00}"
		foreground = "#${colors.base05}"
		black = "#${colors.base00}"
		red = "#${colors.base08}"
		green = "#${colors.base0B}"
		yellow = "#${colors.base0A}"
		blue = "#${colors.base0C}"
		magenta = "#${colors.base0E}"
		cyan = "#${colors.base0C}"
		white = "#${colors.base06}"
		bright_black = "#${colors.base01}"
		bright_red = "#${colors.base09}"
		bright_green = "#${colors.base0B}"
		bright_yellow = "#${colors.base0A}"
		bright_blue = "#${colors.base0C}"
		bright_magenta = "#${colors.base0D}"
		bright_cyan = "#${colors.base0C}"
		bright_white = "#${colors.base07}"
	'';
}
