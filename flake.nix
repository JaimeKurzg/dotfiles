{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
	stylix.url = "github:danth/stylix";
    xremap-flake.url = "github:xremap/nix-flake";
	firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	nixvim = {
        url = "github:nix-community/nixvim/nixos-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  	let 
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
	nixosConfigurations = {
		nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; };
			modules = [./configuration.nix ];
		};
	  };
	homeConfigurations = {
		jaimek = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = { 
				inherit inputs; 
			};
			modules = [./home.nix ];
		};
	};
	};
}
