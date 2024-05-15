{config, lib, inputs, pkgs, unstable, ...}:
{

	imports = [
		inputs.nixvim.homeManagerModules.nixvim
	];

	options = {
		nvim.enable = 
		lib.mkEnableOption "use my nvim conf";
	};
	config = lib.mkIf config.nvim.enable {
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
		extraFiles = {
			"after/ftplugin/gdscript.lua" = ''
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

		extraPlugins = with pkgs.vimPlugins; [
			ccc-nvim
			nvim-web-devicons
			{
				plugin = comment-nvim;
				config = ''lua require'Comment'.setup()'';
			}

		];
		plugins = {
			dap = {
				enable = true;
				extensions.dap-ui.enable = true;
				adapters.servers.godot = {
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
			which-key.enable = true;
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
				enable = true;
				indent = true;
				ensureInstalled = [
					"nix"
					"gdscript"
				];
			};

			lsp = {
				enable = true;
				servers = {
					nil_ls.enable = true;
					gdscript.enable = true;
				};
			};
			nvim-cmp = {
				enable = true;
				autoEnableSources = true;
				sources = [
				{name = "nvim_lsp";}
				{name = "path";}
				{name = "luasnip";}
				{name = "buffer";}
				];
				mapping = {
					"<C-Space>" = "cmp.mapping.complete()";
					"<C-d>" = "cmp.mapping.scroll_docs(-4)";
					"<C-e>" = "cmp.mapping.abort()";
					"<C-f>" = "cmp.mapping.scroll_docs(4)";
					"<C-y>" = "cmp.mapping.confirm({ select = true })";
					"<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
					"<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
				};
			};
			flash = {
				enable = true;
			};

			trouble.enable = true;
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
			key = "<leader>db";
			action = "<cmd>lua require'dap'.toggle_breakpoint()<cr>";
			mode = "n";
		}
		{
			key = "<leader>dc";
			action = "function() 
				require'dap'.continue()
				require'dapui'.open()
			end
			";
			mode = "n";
			lua = true;
		}
		{
			key = "<leader>dq";
			action = "function() 
				require'dap'.terminate()
				require'dapui'.close()
			end
			";
			mode = "n";
			lua = true;
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
		{
			key = ";";
			mode = "n";
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
			action = "<cmd>lua vim.lsp.buf.format()<cr>";
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
		{ mode = "n"; key = "<leader>cc"; action = "<cmd>CccPick<cr>"; }


# plugin keys
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
	};
}

