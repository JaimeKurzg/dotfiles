{
	description = "Main Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		sops-nix.url = "github:Mic92/sops-nix";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix/release-23.11";
		stylix.inputs.nixpkgs.follows = "nixpkgs";
		xremap-flake.url = "github:xremap/nix-flake";
		nixvim = {
			url = "github:nix-community/nixvim/nixos-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs:
	let 
		lib = nixpkgs.lib;
		unstable = nixpkgs-unstable.legacyPackages.${system};
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			pc = lib.nixosSystem{
				inherit system;
				modules = [
					./hosts/pc/configuration.nix
				];
				specialArgs = { 
					inherit inputs; 
					inherit unstable;
				};
			};
			nixos = lib.nixosSystem {
				inherit system;
				modules = [
					./hosts/default/configuration.nix
				];
				specialArgs = { 
					inherit inputs; 
					inherit unstable;
				};
			};
			isoimage = lib.nixosSystem {
				inherit system;
				specialArgs = { 
					inherit inputs;
				};
				modules = [ ./hosts/isoimage/configuration.nix ];

			};
		};
		homeConfigurations = {
			jaimek = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
					./home.nix 
					inputs.stylix.homeManagerModules.stylix
				];
				extraSpecialArgs = {
					inherit inputs;
					inherit system;
					inherit unstable;
				};
			};
		};
	};
}
