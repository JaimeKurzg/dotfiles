{config, ...}:
{
# from vimjoyer https://www.youtube.com/watch?v=qlfm3MEbqYA
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.nvidia = {
		modesetting.enable = true;
		open = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
}
