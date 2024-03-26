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
		keyMode = "vi";
		extraConfig = ''
			# split panes using | and -
			bind | split-window -h
			bind - split-window -v
			unbind '"'
			unbind %

# reload config file (change file location to your the tmux.conf you want to use)
			bind r source-file ~/.tmux.conf
			'';
		plugins = 
			with pkgs.tmuxPlugins; [
			sensible
			vim-tmux-navigator
			cpu
			{
				plugin = resurrect;
				extraConfig = "set -g @resurrect-strategy-nvim 'session'";
			}
			{
				plugin = continuum;
				extraConfig = ''
					set -g @continuum-restore 'on'
					set -g @continuum-save-interval '60' # minutes
					'';
			}
			onedark-theme
			jump
			fingers
			];

	};

}
