{	
	imports = [
		./plugins
		./options.nix
		./keymaps.nix
		./godot-nvim.nix
	];
	config = {
		colorschemes.base16 = {
			enable = true;
			colorscheme = "unikitty-dark";
		};
		viAlias = true;
		vimAlias = true;

		globals = {
			mapleader = " ";
		};
	};
}
