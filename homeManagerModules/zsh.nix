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
			enableZshIntegration = true;
		};

		programs.zsh = {
			enable = true;
			autocd = true;
			autosuggestion.enable = true;
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
				"open" = "xdg-open";
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

				set status off
			'';
			plugins = 
				with pkgs.tmuxPlugins; [
					sensible
					vim-tmux-navigator

					{
						plugin = resurrect;
						extraConfig = ''
resurrect_dir="$HOME/.tmux/resurrect"
set -g @resurrect-dir $resurrect_dir
set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'

						'';
					}
					{
						plugin = continuum;
						extraConfig = ''
							set -g @continuum-restore 'on'
							set -g @continuum-save-interval '1' # minutes
						'';
					}
					jump
					tmux-thumbs
				];

		};

	};
}
