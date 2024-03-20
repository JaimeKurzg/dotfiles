return {
	'mfussenegger/nvim-dap',
	ft = "go",
	dependencies = {
		'rcarriga/nvim-dap-ui',
		{
			'leoluz/nvim-dap-go',
			ft = "go",
		},
	},
	keys = {
	},
	config = function()
		require("dapui").setup()
		vim.keymaps.set("n", "<leader>dr",
			function()
				require("dapui").open()
				require("dap").continue()
			end
		)
		vim.keymaps.set("n", "<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end
		)
		vim.keymaps.set("n", "<leader>do",
			function()
				require("dap").step_over()
			end
		)
		vim.keymaps.set("n", "<leader>di",
			function()
				require("dap").step_into()
			end
		)
		vim.keymaps.set("n", "<leader>dc",
			function()
				require("dapui").close()
			end
		)
	end,
}
