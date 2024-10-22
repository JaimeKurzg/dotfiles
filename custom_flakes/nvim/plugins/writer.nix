{...}:
{
	plugins.zen-mode.enable = true;
	keymaps = [
	{
		mode = "n";
		key = "<leader>w";
		action = { 
		__raw = ''
			function()
				print('writers mode')
				vim.opt.wrap = true
				vim.keymap.set('n','j', 'gj')
				vim.keymap.set('n','k', 'gk')
				vim.cmd('ZenMode')
				vim.opt.linebreak = true
				vim.cmd("colorscheme base16-ia-light")
			end
		''; 
		};
	}

	];
	
}
