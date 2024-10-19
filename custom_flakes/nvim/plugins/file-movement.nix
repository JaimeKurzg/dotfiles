{
	plugins.oil = {
		enable = true;
		settings = {
			default_file_explorer = true;
			keymaps = {
				"<leader>\\" = "actions.select_split";
				"<leader>r" = "actions.refresh";
				"<Leader>k" = "actions.parent";
				"<Leader>j" = "actions.select";
				"<Leader>p" = "actions.preview";
				"<Leader>." = "actions.toggle_hidden";
				"<leader>cd" = "actions.cd";
				"<C-h>" = false;
				"<C-l>" = false;
			};
			use_default_keymaps = false;
		};
	};

	extraConfigLua = ''
		local prev_file_mark = false
		vim.keymap.set("n", "<leader>k", function()
			if prev_file_mark then
				prev_file_mark = false
				vim.cmd([[
					normal! 'F
					]])
			else
				vim.cmd('Oil')
			end
		end)
		vim.keymap.set("n", "<leader>j", function()
			prev_file_mark = true
			vim.cmd([[
					normal! mFgf
					]])
		end)
		'';
}
