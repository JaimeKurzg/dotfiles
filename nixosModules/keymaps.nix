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

	options = {
		xremap.enable = lib.mkEnableOption "enable xremap";
	};

	config = lib.mkIf config.xremap.enable {
		systemd.user.services.xremap.serviceConfig.Environment = [
			"PATH=/etc/profiles/per-user/<USERNAME>/bin"
		];

		environment.systemPackages = [
			inputs.xremap-flake.packages.x86_64-linux.default
		];

		services.xremap = {
		yamlConfig = ''
modmap:
- name: CapsChange
  remap:
    CapsLock: Esc
    Esc: CapsLock
keymap:
- name: IDEA (modified from Default)
  remap:
    Super-a:
      remap:
        Super-j: [KEY_5, KEY_J]
        Super-k: [KEY_5, KEY_k]
        Super-h: [KEY_5, Key_h]
        Super-l: [Key_5, Key_l]
    Super-s:
      remap:
        Super-j: C-d
        Super-k: C-u
        Super-h: [Key_1, Key_5, Key_h]
        super-l: [Key_1, Key_5, Key_l]
    Super-d:
      remap:
        Super-j: [Shift-G]
        Super-k: [g,g]
        Super-h: [Shift-Key_6]
        Super-l: [SHIFT-KEY_4]
'';
	};
	};
}
