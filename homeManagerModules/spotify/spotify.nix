{pkgs, config, inputs, ...} : {

	home.packages = with pkgs; [
		spotify-player
	];

	xdg.configFile."spotify-player/app.toml".source = ./app.toml;
	xdg.configFile."spotify-player/keymap.toml".source = ./keymap.toml;
	xdg.configFile."spotify-player/theme.toml".text = ''
		[[themes]]
		name = "stylix"
		[themes.palette]
		background = "#${config.lib.stylix.colors.base00}"
		foreground = "#${config.lib.stylix.colors.base05}"
		black = "#${config.lib.stylix.colors.base00}"
		red = "#${config.lib.stylix.colors.base01}"
		green = "#${config.lib.stylix.colors.base02}"
		yellow = "#${config.lib.stylix.colors.base03}"
		blue = "#${config.lib.stylix.colors.base04}"
		magenta = "#${config.lib.stylix.colors.base05}"
		cyan = "#${config.lib.stylix.colors.base06}"
		white = "#${config.lib.stylix.colors.base07}"
		bright_black = "#${config.lib.stylix.colors.base08}"
		bright_red = "#${config.lib.stylix.colors.base09}"
		bright_green = "#${config.lib.stylix.colors.base0A}"
		bright_yellow = "#${config.lib.stylix.colors.base0B}"
		bright_blue = "#${config.lib.stylix.colors.base0C}"
		bright_magenta = "#${config.lib.stylix.colors.base0D}"
		bright_cyan = "#${config.lib.stylix.colors.base0E}"
		bright_white = "#${config.lib.stylix.colors.base0F}"
	'';
}
