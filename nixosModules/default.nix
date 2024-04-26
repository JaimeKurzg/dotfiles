{lib, config, ...}:
{
	imports = [
		./lmms.nix
		./nixld.nix
		./keymaps.nix
		./syncthing.nix
	];
	lmms.enable = lib.mkDefault true;
}
