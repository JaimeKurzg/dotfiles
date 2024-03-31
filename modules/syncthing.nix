{pkgs, ...} : {
	users.users.jaimek = {
		packages = with pkgs; [
			syncthing
		];
	};
	services.syncthing.enable = true;
	services.syncthing = {
		user = "jaimek";
	};
}
