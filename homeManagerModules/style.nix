{ pkgs, config, lib, ... }:

let
font = (pkgs.nerdfonts.override { fonts = [ "OpenDyslexic" ]; });
theme = ./themes/unikitty.yaml;
#theme = { __raw = ''
#	scheme: "Unikitty Dark"
#		author: "Josh W Lewis (@joshwlewis)"
#		base01: "${mkColor ''#4a464d''}"
#		base00: "${mkColor ''#2e2a31''}" 
#		base02: "${mkColor ''#666369''}" 
#		base03: "${mkColor ''#af8085''}" 
#		base04: "${mkColor ''#9f9da2''}" 
#		base05: "${mkColor ''#bcbabe''}" 
#		base06: "${mkColor ''#d8d7da''}" 
#		base07: "${mkColor ''#f4f3f6''}" 
#		base08: "${mkColor ''#d8137f''}" 
#		base09: "${mkColor ''#d65407''}" 
#		base0A: "${mkColor ''#dc8a0e''}" 
#		base0B: "${mkColor ''#17ad98''}" 
#		base0C: "${mkColor ''#149bda''}" 
#		base0D: "${mkColor ''#796af5''}" 
#		base0E: "${mkColor ''#bb60ea''}" 
#		base0F: "${mkColor ''#c720ca''}" 
#		''; };
wallpaper = ./wallpaper.png;
in 
{
	options = {
		globalstyle.enable = lib.mkEnableOption "enables stylix";
	};
	config = lib.mkIf config.globalstyle.enable {
		stylix = {
			image = wallpaper;
			base16Scheme = theme;
			targets.i3.enable = false;
			targets.k9s.enable = false;

			fonts = {
				monospace = {
					name = "OpenDyslexicM Nerd Font Mono";
					package = font;
				};
				sansSerif = {
					name = "OpenDyslexic Nerd Font";
					package = font;
				};
				serif = {
					name = "OpenDyslexic Nerd Font";
					package = font;
				};
				sizes = {
					terminal = 11;
					applications = 11;
				};
			};
		};
	};
}
