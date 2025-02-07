{pkgs, lib, config, unstable, ...}:
{
	imports = [
		./zsh.nix
		./kitty.nix
		./tmux.nix
	];
	options = {
		shell_config.enable = lib.mkEnableOption "enables terminal config";
	};
	config = lib.mkIf config.shell_config.enable {

		home.packages = with pkgs; [
			zoxide
			xclip
			fd
			bat
		];

		# allows for background blur
		services.picom = {
			enable = true;
			package = unstable.picom;
			backend = "glx";
			settings = {
				blur =
					{ 
						method = "dual_kawase";
						size = 10;
						deviation = 5.0;
					};

			};
		};


		programs.zoxide = {
			enable = true;
		};

		programs.fzf = {
			enable = true;
			tmux.enableShellIntegration = true;
			enableZshIntegration = true;
		};

	};
}
