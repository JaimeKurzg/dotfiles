return {
	-- don't install a plugin, but set these paths.
	dir = "",
	name = "go",

	ft = "go",
	keys = {
		{"<M-'>", "<cmd>!go run %<cr>"}
	},
	verylazy = true
}
