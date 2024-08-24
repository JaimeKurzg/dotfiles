{
	plugins.dap = {
				enable = true;
				extensions.dap-ui.enable = true;
			};
		keymaps = [{
			key = "<leader>db";
			action = "<cmd>lua require'dap'.toggle_breakpoint()<cr>";
			mode = "n";
		}
		{
			key = "<leader>dc";
			action.__raw = "function() 
				require'dap'.continue()
				require'dapui'.open()
			end
			";
			mode = "n";
		}
		{
			key = "<leader>dq";
			action.__raw = "function() 
				require'dap'.terminate()
				require'dapui'.close()
			end
			";
			mode = "n";
		}
		{
			key = "<leader>do";
			action = "<cmd>lua require'dap'.step_over()<cr>";
			mode = "n";
		}
		{
			key = "<leader>di";
			action = "<cmd>lua require'dap'.step_into()<cr>";
			mode = "n";
		}
		{
			key = "<leader>dp";
			action = "<cmd>lua require'dap'.step_out()<cr>";
			mode = "n";
		}
		{
			key = "<leader>dr";
			action = "<cmd>lua require'dap'.restart()<cr>";
			mode = "n";
		}
		];
}
