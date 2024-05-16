{pkgs, ...}:{
	config = {
		extraPlugins = with pkgs.vimPlugins; [
			nvim-web-devicons
			vim-obsession
			{
				plugin = comment-nvim;
				config = ''lua require'Comment'.setup()'';
			}

		];
		plugins = {
			which-key.enable = true;
			trouble.enable = true;
			fugitive.enable = true;
			surround.enable = true;
			tmux-navigator.enable = true;
		};
	};
}
