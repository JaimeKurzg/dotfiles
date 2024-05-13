{lib, config, ...}:
{
	imports = [
		./zsh.nix
		./nvim.nix
		./style.nix
		./qutebrowser.nix
		./youtube.nix
		./gameDev.nix
		./wm/i3/i3.nix
		./spotify/spotify.nix
	];
	youtube.enable = lib.mkDefault false;
	nvim.enable = lib.mkDefault true;
	zsh.enable = lib.mkDefault true;
	i3.enable = lib.mkDefault true;
	qutebrowser.enable = lib.mkDefault true;
	globalstyle.enable = lib.mkDefault true;
	gameDev.enable = lib.mkDefault true;
}
