{
  description = "Main Flake";



  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    xremap-flake.url = "github:xremap/nix-flake";
	firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  	let 




	userSettings = rec {
        username = "jaimek"; # username
        name = "Jaime Kurzweg"; # name/identifier
        email = "jkurzweg10@gmail.com"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        #theme = "uwunicorn-yt"; # selcted theme from my themes directory (./themes/)
        wm = "i3wm"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
        #defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
        term = "kitty"; # Default terminal command;
        font = "Intel One Mono"; # Selected font
        fontPkg = pkgs.intel-one-mono; # Font package
        editor = "nvim"; # Default editor;
        # editor spawning translator
        # generates a command that can be used to spawn editor inside a gui
        # EDITOR and TERM session variables must be set in home.nix or other module
        # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
        spawnEditor = if (editor == "emacsclient") then
                        "emacsclient -c -a 'emacs'"
                      else
                        (if ((editor == "vim") ||
                             (editor == "nvim") ||
                             (editor == "nano")) then
                               "exec " + term + " -e " + editor
                         else
                           editor);
      };

		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
	nixosConfigurations = {
		nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; };
			modules = [ ./configuration.nix ];
		};
	  };
	homeConfigurations = {
		jaimek = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = { 
				inherit inputs; 
				inherit userSettings;
			};
			modules = [ ./home.nix ];
		};
	};
	};
}
