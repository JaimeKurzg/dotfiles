{
	plugins.dap = { adapters.servers.godot = {
					port = 6006;
					host = "127.0.0.1";
				};
				configurations.gdscript = [ {
					type = "godot";
					request = "launch";
					name = "Launch Scene";
					port = 6006;
					project = "\${workspaceFolder}";
				} ];
				};
	extraFiles = {
		"after/ftplugin/gdscript.lua".text = ''
			local port = os.getenv('GDScript_Port') or '6005'
			local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
			local pipe = '/tmp/godot.pipe'

			vim.lsp.start({
					name = 'Godot',
					cmd = cmd,
					root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
					on_attach = function(client, bufnr)
					vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
					end
					})

		'';
	};
}
