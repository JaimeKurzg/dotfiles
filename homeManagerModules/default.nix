{lib, pkgs, inputs, ...}:
{
	imports = [
		./zsh.nix
		./games.nix
		./style.nix
		./qutebrowser.nix
		./youtube.nix
		./gameDev.nix
		./wm/i3/i3.nix
		./spotify/spotify.nix
	];
	youtube.enable = lib.mkDefault false;
	zsh.enable = lib.mkDefault true;
	i3.enable = lib.mkDefault true;
	qutebrowser.enable = lib.mkDefault true;
	globalstyle.enable = lib.mkDefault true;
	gameDev.enable = lib.mkDefault true;


	home.packages = [
		pkgs.ripgrep
		inputs.mynixvim.packages.${pkgs.system}.default
	];
}
