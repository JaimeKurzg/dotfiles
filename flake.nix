{
	description = "Main Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	    musnix.url = "github:musnix/musnix";
		sops-nix.url = "github:Mic92/sops-nix";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix/release-23.11";
		xremap-flake.url = "github:xremap/nix-flake";
		nixvim = {
			url = "github:nix-community/nixvim/nixos-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, stylix, ... }@inputs:
	let 
		lib = nixpkgs.lib;
		unstable = nixpkgs-unstable.legacyPackages.${system};
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = { 
					inherit inputs; 
					inherit unstable;
				};
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
