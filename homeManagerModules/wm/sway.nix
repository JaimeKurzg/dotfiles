{pkgs, config, lib, ...}:

{
	imports = [
		./waybar.nix
	];
	wayland.windowManager.sway = {
		enable = true;
		swaynag.enable = false;
		config = {
			bars = [ {command = "${pkgs.waybar}/bin/waybar";
			}];
			window.border = 0;
			window.titlebar = false;
			workspaceAutoBackAndForth = true;
			modifier = "Mod1";
			terminal = "kitty"; 

			startup = [
				{command = ''swaymsg "workspace 3; exec qutebrowser"'';}
			];
			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
				mod2 = "Mod4";
			in lib.mkOptionDefault {
				"${modifier}+t" = "exec ${pkgs.kitty}/bin/kitty";
				"${modifier}+b" = "workspace --no-auto-back-and-forth number 3; exec ${pkgs.qutebrowser}/bin/qutebrowser";
				"${modifier}+q" = "kill";
				"${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
				"${modifier}+0" = "workspace number 10";
				"${modifier}+Shift+0" = "move container to workspace number 10";
				"${modifier}+w" = "workspace --no-auto-back-and-forth number 10; exec kitty -e spotify_player";
				"XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
				"XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
			};
		};
		extraConfig = ''
			bindsym XF86AudioRaiseVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+'
			bindsym XF86AudioLowerVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-'
			bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'


			for_window [class="Booligrams"] floating enable
			input 2362:14408:PIXA3848:01_093A:3848_Touchpad {
				click_method clickfinger
				middle_emulation enabled
			}
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
