{pkgs}:{
	imports = [
		./plugins
		./options.nix
		./keymaps.nix
	];
	config = {
		viAlias = true;
		vimAlias = true;

		globals = {
			mapleader = " ";
		};
	};
}

