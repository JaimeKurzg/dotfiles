{pkgs, ...}:
{
	imports = [
		./battery_monitor.nix
	];

	modules.battery_monitor.enable = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
        defaultSession = "none+i3";
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
