{pkgs, config, ...} : {
	home.packages = with pkgs; [
		spotify-tui
	];

	services.spotifyd = {
		enable = true;
		settings.global = {
			username = "jkurzweg10@gmail.com";
			password_cmd = "cat ${config.sops.secrets.spotify.path}";
		};
	};
	sops.secrets.spotify = {};
}
