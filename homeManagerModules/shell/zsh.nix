{ config, lib, pkgs, unstable, ... }:
{
		programs.zsh = {
			enable = true;
			autocd = true;
			autosuggestion.enable = true;
			enableCompletion = true;
			defaultKeymap = "viins";
			syntaxHighlighting.enable = true;
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
				"update_nvim" = "nix flake update mynixvim && nh home switch";
				"dot" = "tmuxp load dot";
				"tp" = "tmuxp load";
			};
			initExtra = ''
				bindkey -v '^?' backward-delete-char
				eval "$(zoxide init zsh --cmd cd)"
				function zvm_after_init() {
					zvm_bindkey viins "^R" fzf-history-widget
				}
			'';
		};

}
