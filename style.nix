{ pkgs, config, ... }:

let
theme = "${pkgs.base16-schemes}/share/themes/unikitty-dark.yaml";
wallpaper = "${./.wallpaper.png}";
in 
{
	stylix = {
		image = wallpaper;
		base16Scheme = theme;
		fonts = {
			monospace = {
				name = "OpenDyslexicMono-Regular";
				package = pkgs.open-dyslexic;
			};
			sansSerif = {
				name = "OpenDyslexic-Regular";
				package = pkgs.open-dyslexic;
			};
			serif = {
				name = "OpenDyslexic-Regular";
				package = pkgs.open-dyslexic;
			};
			sizes = {
				terminal = 11;
				applications = 11;
			};
		};
	};
}
