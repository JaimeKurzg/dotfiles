{pkgs, config, lib, ...}:

{
	imports = [
		./waybar.nix
	];
	wayland.windowManager.sway = {
		enable = true;
		config = {
			bars = [ {command = "${pkgs.waybar}/bin/waybar";
			}];
			window.border = 0;
			window.titlebar = false;
			modifier = "Mod1";
			terminal = "kitty"; 

			startup = [
				{command = ''exec swaymsg "workspace 3; exec qutebrowser"'';}
			];
			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
				mod2 = "Mod4";
			in lib.mkOptionDefault {
				"${modifier}+t" = "exec ${pkgs.kitty}/bin/kitty";
				"${modifier}+b" = "workspace number 3; exec ${pkgs.qutebrowser}/bin/qutebrowser";
				"${modifier}+q" = "kill";
				"${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
				"${modifier}+0" = "workspace number 10";
				"${modifier}+Shift+0" = "move container to workspace number 10";
				"${modifier}+w" = "workspace number 10; exec kitty -e spotify_player";
				"XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
				"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
			};
		};
		extraConfig = ''
			bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +10%'
			bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -10%'
			bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
			'';
	};

	home.packages = with pkgs; [
		brightnessctl
		grim # screenshot functionality
		slurp # screenshot functionality
		wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
		mako # notification system developed by swaywm maintainer
	];
}
