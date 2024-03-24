{ config, lib, pkgs, ... }:

{

	home.packages = with pkgs; [
		zoxide
			xclip
			fd
			zsh
			fzf
			zoxide
			oh-my-zsh
			bat
	];

	programs.kitty = {
		enable = true;
		theme = "Space Gray Eighties";
#	font = {
#		name = "Awesome";
#		package = pkgs.font-awesome;
#	};
	};

	programs.zoxide = {
		enable = true;
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.zsh = {
		enable = true;
		autocd = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		defaultKeymap = "vicmd";
		shellAliases = {
			"clip" = "xclip -selection clipboard";
			"cat" = "bat";
		};
		initExtra = ''
			eval "$(zoxide init zsh --cmd cd)"
			'';
	};
	programs.tmux = {
		enable = true;
		prefix = "C-a";
		mouse = false;
		shell = "${pkgs.zsh}/bin/zsh";
	};

}
