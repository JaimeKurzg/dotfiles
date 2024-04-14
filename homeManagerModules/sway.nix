{pkgs, ...}:

{
		wayland.windowManager.sway = {
			enable = true;
			config = rec {
				#bars.command = "\${pkgs.waybar}/bin/waybar";
				modifier = "Mod1";
# Use kitty as default terminal
				terminal = "kitty"; 
				startup = [
# Launch Firefox on start
				{command = "qutebrowser";}
				];
			};
			extraConfig = ''
				bindsym XF86MonBrightnessDown exec light -U 10
				bindsym XF86MonBrightnessUp exec light -A 10

# Volume
				bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
				bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
				bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
				'';

		};

	home.packages = with pkgs; [
		waybar
			grim # screenshot functionality
			slurp # screenshot functionality
			wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
			mako # notification system developed by swaywm maintainer
	];
}
