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

						};
				} )

		];
	};
}
