{
	plugins.flash.enable = true;

	keymaps = [
	{
		key = "S";
		action = ''<cmd>lua require("flash").treesitter()<CR>'';
	}
	{
		key = "s";
		action = ''<cmd>lua require("flash").jump()<CR>'';
	}
	];
}
