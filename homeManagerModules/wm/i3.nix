{pkgs, config, lib, ...}:

{
	imports = [
		./polybar.nix
	];

	xsession.windowManager.i3 = {
		enable = true;
		config = {
			window.border = 0;
			window.titlebar = false;
			workspaceAutoBackAndForth = true;
			modifier = "Mod1";
			terminal = "kitty"; 
			bars = [ ];
			startup = [
			{
				command = "systemctl --user restart polybar.service";
				always = true;
				notification = false;
			}

			];
			keybindings = let
				modifier = "Mod1";
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
			"XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
			"XF86AudioLowerVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
			"XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
			};
		};
		extraConfig = ''
			for_window [class="Booligrams"] floating enable
#			input 2362:14408:PIXA3848:01_093A:3848_Touchpad {
#				click_method clickfinger
#				middle_emulation enabled
#			}
			'';
	};

	home.packages = with pkgs; [
		brightnessctl
	];
}
