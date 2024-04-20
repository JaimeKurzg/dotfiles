{config, inputs, pkgs, lib, system, ...}:
let
left = "h";
down = "j";
up = "k";
right = "l";
in {

	imports = [

		inputs.xremap-flake.nixosModules.default
	];

	systemd.user.services.xremap.serviceConfig.Environment = [
		"PATH=/etc/profiles/per-user/<USERNAME>/bin"
	];

environment.systemPackages = [
	inputs.xremap-flake.packages.x86_64-linux.default
];

	services.xremap = {
		enable = true;
		withWlroots = true;
		userName = "jaimek";
		config = {
			modmap = [
			{
				name = "caps-esc replace";
				remap = { 
					"CapsLock" = "Esc";
					"Esc" = "CapsLock";
				};
			}
			];
#			keymap = [
#
#			{
#				name = "sound";
#				remap.KEY_VOLUMEUP.launch = ["${pkgs.wireplumber}/bin/wpctl" "set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"];
#				remap.KEY_VOLUMEDOWN.launch = ["bash" "-c" "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"];
#				remap.KEY_MUTE.launch = ["bash" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
#			}
#			];
		};
	};
}
