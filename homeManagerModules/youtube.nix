{pkgs, ...}:
{
	home.packages = with pkgs; [
		kdenlive
		obs-studio
		audacity
	];
}
