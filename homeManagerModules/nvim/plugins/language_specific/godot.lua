return {
	"lommix/godot.nvim",
	ft = {"*.gd", "*.tscn", "*.tres", "gdscript"},
	config = function()
		require'godot'.setup()
		vim.keymap.set("n", "<leader>dr", "<cmd>:GodotDebug<cr>")
		vim.keymap.set("n", "<leader>dq", "<cmd>:GodotQuit<cr>")
		vim.keymap.set("n", "<leader>dd", "<cmd>:GodotBreakAtCursor<cr>")
		vim.keymap.set("n", "<leader>ds", "<cmd>:GodotStep<cr>")
		vim.keymap.set("n", "<leader>dc", "<cmd>:GodotContinue<cr>")
	end,
	opts = {
		bin = function ()
			return "godot"
		end,
	}
}
