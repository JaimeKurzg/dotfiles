{pkgs, ...}:
{ imports = [
	./dap.nix
	./leap.nix
	./telescope.nix
	./file-movement.nix
	./cmp-lsp-ts.nix
	./color-picker.nix
	./writer.nix
	#./godot-nvim.nix
];
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
