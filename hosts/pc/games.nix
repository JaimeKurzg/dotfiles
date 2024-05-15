{pkgs, lib, ...}:
{
	nixpkgs.config.allowUnfree = lib.mkDefault true;
	environment.systemPackages = with pkgs; [
		unstable.prismlauncher
		lutris
	];

	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;
	programs.gamemode.enable = true;
}
