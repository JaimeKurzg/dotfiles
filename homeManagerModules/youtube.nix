{pkgs, lib, config, ...}:
{
	options = {
		youtube.enable = 
		lib.mkEnableOption "enables youtube creation";
	};
	config = lib.mkIf config.youtube.enable {
	home.packages = with pkgs; [
		kdenlive
		obs-studio
		audacity
	];
	};
}
