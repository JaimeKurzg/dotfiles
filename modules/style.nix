{ pkgs, config, lib, ... }:

let 
#	mkColor = color : lib.strings.removePrefix "#" color ;
in
let
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
wallpaper = ./.wallpaper.png;
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
