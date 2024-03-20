{config, pkgs, ...}:
let 
	toLua = str: "lua << EOF\n${str}\nEOF\n";
	toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
	programs.neovim = {

		enable = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		defaultEditor = true;

		plugins = with pkgs.vimPlugins; [
			nvim-web-devicons
			{
				plugin = oil-nvim;
				config = toLuaFile ./nvim/plugins/oil.lua;
			}
			{
				plugin = rose-pine;
				config = "colorscheme rose-pine";
			}
			{
				plugin = telescope-nvim;
				config = toLuaFile ./nvim/plugins/telescope.lua;
			}
			telescope-z-nvim
		];
		extraLuaConfig = ''
			${builtins.readFile ./nvim/options.lua}
			${builtins.readFile ./nvim/keymaps.lua}
			vim.keymap.set("n", "<leader>k", "<cmd>Oil<cr>")
		'';
	};
}

