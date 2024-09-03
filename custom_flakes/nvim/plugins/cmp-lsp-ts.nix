{
	plugins = {
		treesitter = {
			enable = true;
			settings.indent.enable = true;
			settings.ensure_installed = [
				"nix"
				"gdscript"
			];
		};

		lsp = {
			enable = true;
			servers = {
				nil-ls.enable = true;
				gdscript.enable = true;
			};
		};
		cmp = {
			enable = true;
			autoEnableSources = true;
			# sources = [
			# {name = "nvim_lsp";}
			# {name = "path";}
			# {name = "luasnip";}
			# {name = "buffer";}
			# ];
			settings.mapping = {
				"<C-Space>" = "cmp.mapping.complete()";
				"<C-d>" = "cmp.mapping.scroll_docs(-4)";
				"<C-e>" = "cmp.mapping.abort()";
				"<C-f>" = "cmp.mapping.scroll_docs(4)";
				"<C-y>" = "cmp.mapping.confirm({ select = true })";
				"<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
				"<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
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

