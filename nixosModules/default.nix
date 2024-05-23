{lib, config, ...}:
{
	imports = [
		./lmms.nix
		./nixld.nix
		./syncthing.nix
		./keymaps.nix
	];
	lmms.enable = lib.mkDefault true;
	xremap.enable = lib.mkDefault true;
}
