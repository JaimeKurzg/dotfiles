{pkgs, ...}:
{
		programs.tmux = {
			enable = true;
			prefix = "C-a";
			mouse = true;
			shell = "${pkgs.zsh}/bin/zsh";
			keyMode = "vi";
			tmuxp.enable = true;
			extraConfig = ''
# split panes using | and -
				bind | split-window -h
				bind - split-window -v
				unbind '"'
				unbind %

				# Ctrl-u and C-d scroll up and down, but passes through to vim
				# ideally this would work directly in zsh
				bind -n C-u if -F "#{?#{m:\*vim\*,#{pane_current_command}},0,1}" "copy-mode \; send-key -N 16 k" "send-key C-u"
				bind -T copy-mode-vi C-d send-key -N 16 j
				bind -T copy-mode-vi Escape send-keys -X cancel

				set status off
			'';
			plugins = 
				with pkgs.tmuxPlugins; [
					sensible
					# vim-tmux-navigator
					copycat
					yank
				];

		};
}
