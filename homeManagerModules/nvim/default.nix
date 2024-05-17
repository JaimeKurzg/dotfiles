{inputs, lib, pkgs, config, ...}:
{
	options = {
		nvim.enable = 
			lib.mkEnableOption "use my neovim config";
	};
	config = lib.mkIf config.nvim.enable {

		home.packages = [
			pkgs.ripgrep

				( inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
				  module = 

				  {...}:{
				  imports = [
					  ./plugins
					  ./options.nix
					  ./keymaps.nix
					  ./godot-nvim.nix
				  ];
				  config = {
					  viAlias = true;
					  vimAlias = true;

					  globals = {
					  mapleader = " ";
					  };
				  };

				  };
				  } )

		];
	};
}
