{pkgs, lib, hostname, ...} : {
	users.users.jaimek = {
		packages = with pkgs; [
			syncthing
		];
	};
	services.syncthing = 
		let otherDevices = lib.lists.remove hostname [ "laptop" ];
	in {
		enable = true;
		user = "jaimek";
		dataDir = "/home/jaimek/Sync";
		configDir = "/home/jaimek/.config/syncthing";
		overrideDevices = true;
		overrideFolders = true;
		settings = {
			devices = {
				"laptop" = { id = "PTN3SAM-EVVUHD3-4TG7FGL-YOOW6DL-J25A5TO-CXSYRBX-TS467W3-7LFBPQF"; };
				"phone" = { id = "EVPUD4D-AYESX45-3ADG2LA-6ITHZF3-5WMBUFK-URVPQSZ-Z7V22VZ-3QN4EA3"; };
			};
			folders = {
				"documents" = {
					path = "/home/jaimek/Sync";
					devices = otherDevices ++ [ "phone" ];
					versioning = {
						type = "trashcan";
						params.cleanoutDays = "0";
					};
				};
				"dotfiles" = {
					path = "/home/jaimek/dotfiles";
					devices = otherDevices ++ [ "phone" ];
					versioning = {
						type = "trashcan";
						params.cleanoutDays = "0";
					};
				};
			};
		};
	};
}
