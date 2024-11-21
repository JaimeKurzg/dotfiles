{ config, lib, pkgs, unstable, ... }:
{
	options = {
		zsh.enable = lib.mkEnableOption "enables terminal config";
	};
	config = lib.mkIf config.zsh.enable {

		home.packages = with pkgs; [
			zoxide
			xclip
			fd
			zsh
			fzf
			oh-my-zsh
			bat
		];

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
		programs.kitty = {
			enable = true;
			settings = lib.mkForce {
				background_opacity = "0.7";
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

		# programs.oh-my-posh = {
		# 	enable = true;
		# 	useTheme = "";
		# 	enableZshIntegration = true;
		# };
		programs.zsh = {
			enable = true;
			autocd = true;
			autosuggestion.enable = true;
			enableCompletion = true;
			defaultKeymap = "viins";
			plugins = [
				{ # allows using zsh in nix-shell
					name = "zsh-nix-shell";
					file = "nix-shell.plugin.zsh";
					src = pkgs.fetchFromGitHub {
						owner = "chisui";
						repo = "zsh-nix-shell";
						rev = "v0.8.0";
						sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
					};
				}
				{
					name = "vi-mode";
					src = pkgs.zsh-vi-mode;
					file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
				}
			];
			shellAliases = {
				"clip" = "xclip -selection clipboard";
				"cat" = "bat";
				"open" = "xdg-open";
				"v" = "nvim .";
				"la" = "ls -a";
				"ll" = "ls -la";
				"update_nvim" = "nix flake lock --update-input mynixvim";
				"dot" = "tmuxp load dot";
				"tp" = "tmuxp load dot";
			};
			initExtra = ''
				bindkey -v '^?' backward-delete-char
				eval "$(zoxide init zsh --cmd cd)"
				function zvm_after_init() {
					zvm_bindkey viins "^R" fzf-history-widget
				}
			'';
		};
		programs.tmux = {
			enable = true;
			prefix = "C-a";
			mouse = true;
			shell = "${pkgs.zsh}/bin/zsh";
			# keyMode = "vi";
			tmuxp.enable = true;
			extraConfig = ''
# split panes using | and -
				bind | split-window -h
				bind - split-window -v
				unbind '"'
				unbind %

				set status off
			'';
			plugins = 
				with pkgs.tmuxPlugins; [
					sensible
					vim-tmux-navigator
					jump
					{
						plugin = tmux-thumbs;
						extraConfig = ''
							set -g @thumbs-osc52 1
						'';
					}
				];

		};

	};
}
