{
	plugins.telescope = {
		enable = true;
		keymaps = {
			"<leader>sh" = { 
				action = "help_tags";
				desc = "[S]earch [H]elp"; 
			};
			"<leader>sk" = { 
				action = "keymaps";
				desc = "[S]earch [K]eymaps"; 
			};
			"<leader>sf" = { 
				action = "find_files";
				desc = "[S]earch [F]iles"; 
			};
			"<leader>ss" = { 
				action = "builtin";
				desc = "[S]earch [S]elect Telescope"; 
			};
			"<leader>sw" = { 
				action = "grep_string";
				desc = "[S]earch current [W]ord"; 
			};
			"<leader>sg" = { 
				action = "live_grep";
				desc = "[S]earch by [G]rep"; 
			};
			"<leader>sd" = { 
				action = "diagnostics";
				desc = "[S]earch [D]iagnostics"; 
			};
			"<leader>sr" = { 
				action = "resume";
				desc = "[S]earch [R]esume"; 
			};
			"<leader>s." = { 
				action = "oldfiles";
				desc = "[S]earch Recent Files ('.' for repeat)"; 
			};
			"<leader><leader>" = { 
				action = "buffers";
				desc = "[ ] Find existing buffers"; 
			};
		};
	};
}
