{pkgs, ...}:
{ imports = [
	./dap.nix
	./leap.nix
	./telescope.nix
	./file-movement.nix
	./cmp-lsp-ts.nix
	./color-picker.nix
	./writer.nix
	./haxe.nix
	#./godot-nvim.nix
];
	config = {
		extraPlugins = with pkgs.vimPlugins; [
			vim-obsession
			{
				plugin = comment-nvim;
				config = ''lua require'Comment'.setup()'';
			}

		];
		plugins = {
			web-devicons.enable = true;
			which-key.enable = true;
			trouble.enable = true;
			fugitive.enable = true;
			vim-surround.enable = true;
			tmux-navigator.enable = true;
		};
		keymaps = [{ 
			mode = "n";
			key = "<leader>xx";
			action = "<cmd>Trouble diagnostics toggle<cr>";
		}];

	};

}
