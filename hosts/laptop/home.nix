{ config, pkgs, inputs, ... }:

{
imports = [
	inputs.sops-nix.homeManagerModules.sops
	../../homeManagerModules
];

home.packages = with pkgs; [
	zenity # allows lmms to open file manager window
	element-desktop
	audacity
];

globalstyle.enable = true;

home.username = "jaimek";
home.homeDirectory = "/home/jaimek";

# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
home.stateVersion = "23.11"; # Please read the comment before changing.

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
home.file = {
};

home.sessionVariables = {
	EDITOR = "nvim";
};

programs.rofi = {
	plugins = [ pkgs.rofi-calc ];
	enable = true;
};

programs.git = {
	enable = true;
	userName = "Jaime Kurzweg";
	userEmail = "jaimekurzg@gmail.com";
	extraConfig  = {
		init.defaultBranch = "master";
		push.autoSetupRemote = true;
	};
};

sops = {
	defaultSopsFile = ./secrets/secrets.yaml;
	defaultSopsFormat = "yaml";
	age.keyFile = "/home/jaimek/.config/sops/age/keys.txt";
	defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";
};


xdg.mimeApps = {
  enable = true;
  
  defaultApplications = {
    "text/html" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
		"inode/directory" = "thunar.desktop";
		"inode/file" = "thunar.desktop";
		"application/pdf" = ["org.gnome.Evince.desktop"];
	};
	associations.added = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
	};
};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

