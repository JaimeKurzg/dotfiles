{lib, pkgs, config, ...}:
{
	options = {
		gameDev.enable = 
		lib.mkEnableOption "use godot";
	};
	config = lib.mkIf config.gameDev.enable {
		home.packages = with pkgs; [
			godot_4
		];
	};
}
