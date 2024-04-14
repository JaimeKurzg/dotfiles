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
			{command = "qutebrowser";}
			];
			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${modifier}+t" = "exec ${pkgs.kitty}/bin/kitty";
				"${modifier}+b" = "exec ${pkgs.qutebrowser}/bin/qutebrowser";
				"${modifier}+q" = "kill";
				"${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
				"${modifier}+0" = "workspace number 10";
				"${modifier}+Shift+0" = "move container to workspace number 10";
				"XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
				"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
			};

			defaultWorkspace = "3";
			assigns = {
				"1" = [{ class = "^kitty$"; }];
				"3" = [{ class = "^qutebrowser$"; }];
				"10" = [{ class = "^spotify-player$";}];
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
