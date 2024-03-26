{
	description = "Main Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix/release-23.11";
		xremap-flake.url = "github:xremap/nix-flake";
		nixvim = {
			url = "github:nix-community/nixvim/nixos-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
		let 
		lib = nixpkgs.lib;
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; };
				modules = [
					./configuration.nix 
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.jaimek = import ./home.nix;
# Optionally, use home-manager.extraSpecialArgs to pass
# arguments to home.nix
						home-manager.extraSpecialArgs = {
							inherit inputs;
						};
					}
					stylix.nixosModules.stylix

				];
			};
		};
	};
}
