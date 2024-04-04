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
		defaultKeymap = "viins";
		plugins = [{
			name = "zsh-nix-shell";
			file = "nix-shell.plugin.zsh";
			src = pkgs.fetchFromGitHub {
				owner = "chisui";
				repo = "zsh-nix-shell";
				rev = "v0.8.0";
				sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
			};
		}];
		shellAliases = {
			"clip" = "xclip -selection clipboard";
			"cat" = "bat";
		};
		initExtra = ''
			bindkey -v '^?' backward-delete-char
			eval "$(zoxide init zsh --cmd cd)"
			export NIX_BUILD_SHELL=zsh
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
