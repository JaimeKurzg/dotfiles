{ config, pkgs, inputs, ... }:

{
imports = [
	inputs.nixvim.homeManagerModules.nixvim
	./homeManagerModules/spotify.nix
	./homeManagerModules/youtube.nix
	./homeManagerModules/qutebrowser.nix
	./homeManagerModules/nvim.nix
	./homeManagerModules/zsh.nix
];
#	++ homeManagerModules;

#nixpkgs.config.allowUnfree = true;

home.username = "jaimek";
home.homeDirectory = "/home/jaimek";

# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
home.stateVersion = "23.11"; # Please read the comment before changing.

home.packages = with pkgs; [
	(callPackage ./derivations/goost.nix {})
];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
home.file = {
};

home.sessionVariables = {
	EDITOR = "nvim";
};

programs.rofi = {
	enable = true;
};

programs.git = {
	enable = true;
	userName = "Jaime Kurzweg";
	userEmail = "jkurzweg10@gmail.com";
	extraConfig  = {
		init.defaultBranch = "master";
		push.autoSetupRemote = true;
	};
};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

