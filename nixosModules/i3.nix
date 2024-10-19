{pkgs, ...}:
{
	imports = [
		./battery_monitor.nix
	];

	modules.battery_monitor.enable = true;

	services.displayManager = {
		defaultSession = "none+i3";
	};
	services.xserver = {
		enable = true;

		desktopManager = {
			xterm.enable = false;
		};


		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu #application launcher most people use
				i3lock #default i3 screen locker
				dunst
				flameshot
			];
		};

	};
}
