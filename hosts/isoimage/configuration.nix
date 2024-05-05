{config, lib, pkgs, modulesPath, ...}:

{
	imports = [
		"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
	];
	nixpkgs.hostPlatform = "x86_64-linux";

	networking.wireless.enable = false;
	networking.networkmanager.enable = true;
	programs.nm-applet.enable = true;

	environment.systemPackages = with pkgs; [
		neovim
		firefox
	];

	nix.settings.experimental-features=["nix-command" "flakes"];

	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
	};

	environment.gnome.excludePackages = (with pkgs; [
			gnome-photos
			gnome-tour
			xterm
			gedit # text editor
	]) ++ (with pkgs.gnome; [
		gnome-music
		epiphany # web browser
		geary # email reader
		evince # document viewer
		gnome-characters
		totem # video player
		tali # poker game
		iagno # go game
		hitori # sudoku game
		atomix # puzzle game
	]);

	nixpkgs.overlays = [
		(final: prev: {
		 gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
				 mutter = gnomePrev.mutter.overrideAttrs ( old: {
						 src = pkgs.fetchgit {
						 url = "https://gitlab.gnome.org/vanvugt/mutter.git";
# GNOME 45: triple-buffering-v4-45
						 rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
						 sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
						 };
						 } );
				 });
		 })
	];

}
