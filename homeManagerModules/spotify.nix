{pkgs, ...} : {
	home.packages = with pkgs; [
		spotify-tui
	];

	services.spotifyd = {
		enable = true;
		settings.global = {
			username = "jkurzweg10@gmail.com";
			password_cmd = "pass spotify";
		};

	};
}
