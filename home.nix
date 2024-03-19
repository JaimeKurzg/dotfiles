{ config, pkgs, inputs, ... }:

{
imports = [];
#	++ homeManagerModules;

home.username = "jaimek";
home.homeDirectory = "/home/jaimek";

# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
home.stateVersion = "23.11"; # Please read the comment before changing.

home.packages = [
	pkgs.spotify-player
	pkgs.tridactyl-native
];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
home.file = {
	#".config/i3/config".source = ./i3-config;
};

home.sessionVariables = {
	EDITOR = "nvim";
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

programs.firefox = {
	enable = true;
	profiles.jaimek = {
		extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
			ublock-origin
			tridactyl
			dictionaries
			sponsorblock
		];
	};
};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

