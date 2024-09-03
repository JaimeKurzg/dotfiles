{pkgs, ...}:{
	extraPlugins = with pkgs.vimPlugins; [
		ccc-nvim
	];
	keymaps = [
		{ mode = "n"; key = "<leader>cc"; action = "<cmd>CccPick<cr>"; }
	];
}
