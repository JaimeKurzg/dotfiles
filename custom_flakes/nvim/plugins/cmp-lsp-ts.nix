{pkgs, ...}:

{
	# disables lsp and ts so files over .5Mb don't freeze computer
	extraPlugins = with pkgs.vimPlugins; [bigfile-nvim];
	extraConfigLua = ''require('bigfile').setup({ filesize = 0.5, }) '';

	plugins = {
		treesitter = {
			enable = true;
			settings.indent.enable = true;
			settings.ensure_installed = [
				"nix"
				"python"
				"dart"
			];
		};

		lsp = {
			enable = true;
			servers = {
				nixd.enable = true;
				pylsp.enable = true;
				dartls.enable = true;
			};
		};
		cmp = {
			enable = true;
			autoEnableSources = true;
			settings = {
				sources = [
					{name = "nvim_lsp";}
					{name = "path";}
					{name = "luasnip";}
					{name = "buffer";}
				];
				mapping = {
					"<C-d>" = "cmp.mapping.scroll_docs(-4)";
					"<C-e>" = "cmp.mapping.abort()";
					"<C-f>" = "cmp.mapping.scroll_docs(4)";
					"<C-y>" = "cmp.mapping.confirm({ select = true })";
					"<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
					"<C-Space>" = ''cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.confirm({ select = true }) 
								else
									cmp.complete()
								end
							end, {'i', 's'})
					'';

					"<C-n>" = ''cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
								else
									cmp.complete() 
								end
							end, {'i', 's'})
					'';
				};
			};
		};
	};
	keymaps = [
		{
			mode = "n";
			key = "<leader>f";
			action = "<cmd>lua vim.lsp.buf.format()<cr>";
		}
		{
			mode = "n";
			key = "<leader>e";
			action = "<cmd>lua vim.diagnostic.open_float()<CR>";
		}
	];
}

