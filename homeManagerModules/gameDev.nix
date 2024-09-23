{lib, pkgs, unstable, inputs, config, ...}:
{
	options = {
		gameDev.enable = 
		lib.mkEnableOption "use godot";
	};
	config = lib.mkIf config.gameDev.enable {
		home.packages = with pkgs; [
			unstable.godot_4
			# (pkgs.callPackage ./godot.nix {})
			(import ./shScripts/nvim-godot.nix { inherit pkgs; })
		];

		# programs.nixvim = {
		# 	extraPlugins = with pkgs.vimPlugins; [
		# 	];
		# };
	};
}
