{config, pkgs, ...}:
{
	home.packages = with pkgs; [
		ripgrep
	];

	programs.nixvim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		defaultEditor = true;

		globals = {
			mapleader = " ";
		};

		options = {
			mouse = "";
			nu = true;
			relativenumber = true;
			tabstop = 4;
			softtabstop = 4;
			shiftwidth = 4;
			smartindent = true;
			wrap = false;
			swapfile = false;
			backup = false;
			undofile = true;
			hlsearch = false;
			incsearch = true;
			termguicolors = true;
			scrolloff = 8;
			signcolumn = "yes";
			updatetime = 50;
		};

		#colorschemes.rose-pine.enable = true;
		plugins = {
			oil = {
				enable = true;
				defaultFileExplorer = true;
				keymaps = {
					"<leader>\\" = "actions.select_split";
					"<leader>r" = "actions.refresh";
					"<Leader>k" = "actions.parent";
					"<Leader>j" = "actions.select";
					"<Leader>p" = "actions.preview";
					"<Leader>." = "actions.toggle_hidden";
					"<leader>cd" = "actions.cd";
				};
				useDefaultKeymaps = false;
			};
			treesitter = {
				folding = true;
				indent = true;
				ensureInstalled = [
					"tree-sitter-nix"
				];
			};
			lsp = {
				enable = true;
				servers = {
					nil_ls.enable = true;
				};
			};
			cmp_luasnip.enable = true;
			nvim-cmp = {
				enable = true;
				autoEnableSources = true;
				sources = [
					{name = "nvim_lsp";}
					{name = "path";}
					{name = "buffer";}
					{name = "luasnip";}
				];

				mapping = {
					"<Ctrl-y>" = "cmp.mapping.confirm({ select = true })";
					"<Ctrl-n>" = "cmp.mapping.select_next_item()";
					"<Ctrl-p>" = "cmp.mapping.select_prev_item()";
				};
			};
			flash = {
				enable = true;
			};

			fugitive.enable = true;
			surround.enable = true;
			tmux-navigator.enable = true;
			telescope = {
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
		};


		keymaps = [

			{
				mode = "n";
				key = ";";
				action = ":";
			}
			{
				mode = "v";
				key = "J";
				action = ":m '>+1<CR>gv=gv";
			}
			{
				mode = "v";
				key = "K";
				action = ":m '<-2<CR>gv=gv";
			}

			{
				mode = "n";
				key = "J";
				action = "mzJ`z";
			}
			{
				mode = "n";
				key = "<C-d>";
				action = "<C-d>zz";
			}
			{
				mode = "n";
				key = "<C-u>";
				action = "<C-u>zz";
			}
			{
				mode = "n";
				key = "n";
				action = "nzzzv";
			}
			{
				mode = "n";
				key = "N";
				action = "Nzzzv";
			}

			{
				mode = "x";
				key = "<leader>p";
				action = ''"_dP'';
			}

			{
				mode = ["n" "v"];
				key = "<leader>y";
				action = ''"+y'';
			}
			{
				mode = "n";
				key = "<leader>Y";
				action = ''"+Y'';
			}

			{
				mode = ["n" "v"];
				key = "<leader>d";
				action = ''"_d'';
			}

			{
				mode = "n";
				key = "Q";
				action = "<nop>";
			}
			{
				mode = "n";
				key = "<leader>f";
				action = "<cmd>lua vim.lsp.buf.format()";
			}
			{
				mode = "n";
				key = "<leader>e";
				action = "<cmd>lua vim.diagnostic.open_float()<CR>";
			}

			{
				mode = "n";
				key = "<leader>s";
				action = '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'';
			}
			{
				mode = "n";
				key = "<leader>x";
				action = "<cmd>!chmod +x %<CR>";
				options = { silent = true; };
			}



# plugin keys
			{
				mode = "n";
				key = "<leader>vpp";
				action = "<cmd>Oil ~/.config/nvim/<CR>";
			}
			{
				action = "<cmd>Oil<cr>";
				key = "<leader>k";
				mode = "n";
			}
			{
				key = "S";
				action = ''<cmd>lua require("flash").treesitter()<CR>'';
			}
			{
				key = "s";
				action = ''<cmd>lua require("flash").jump()<CR>'';
			}

		];
	};
#			nvim-web-devicons
#			telescope-z-nvim
}

