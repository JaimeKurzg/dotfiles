{pkgs, ...}:
{
	services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
	musnix = {
		enable = true;
	};
environment.systemPackages = with pkgs; [
		wine
		lmms
		vital
	];
}
