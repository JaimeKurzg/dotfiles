{lib, pkgs, unstable, inputs, config, ...}:
{
	options = {
		gameDev.enable = 
		lib.mkEnableOption "use godot";
	};
	config = lib.mkIf config.gameDev.enable {
		home.packages = with pkgs; [
			unstable.godot_4
			aseprite
			zip

			# (pkgs.callPackage ./godot.nix {})
			(import ./shScripts/nvim-godot.nix { inherit pkgs; })
		];

	};
}
