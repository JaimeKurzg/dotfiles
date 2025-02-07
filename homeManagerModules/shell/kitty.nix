{pkgs, lib, ...}:
{


		programs.kitty = {
			enable = true;
			settings = lib.mkForce {
				background_opacity = "0.7";
			};
			extraConfig = ''
				allow_remote_control yes
				listen_on unix:@mykitty
				map ctrl+j kitten pass_keys.py bottom ctrl+j
				map ctrl+k kitten pass_keys.py top    ctrl+k
				map ctrl+h kitten pass_keys.py left   ctrl+h
				map ctrl+l kitten pass_keys.py right  ctrl+l

			'';

		};
}
