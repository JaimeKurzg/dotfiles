{config, inputs, pkgs, lib, ...}:
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

	services.xremap = {
		enable = true;
		withWlroots = true;
		config = {
			keymap = [
			{
				name = "caps-esc replace";
				remap = { 
					"CapsLock" = "Esc";
					"Esc" = "CapsLock";
				};
			}
		  {
  name = "apps";
  remap.alt-f.launch = [ "${lib.getExe pkgs.pavucontrol}" "pavucontrol" ];

}
		];
		};
	};
}
