{ pkgs, ... }:
let

	# haxe-language-server = pkgs.stdenv.mkDerivation {
	# 	pname = "haxe-language-server";
	# 	version = "900c057";
	# 	src = pkgs.fetchFromGitHub {
	# 		owner = "vshaxe";
	# 		repo = "haxe-language-server";
	# 		rev = "900c0570372f8f592724b25ac52ababe1ef5717";
	# 		hash = "sha256-7bg7/3drvQfxw8Kq0CUhtti8jad+2XID28y6Ucpkd6k";
	# 	};
	# 	
	# 	buildInputs = [
	# 		pkgs.nodejs
	# 	];
	#
	# 	buildPhase = ''
	# 		npm ci
	# 		npx lix run vshaxe-build -t language-server
	# 	'';
	# };
	
	# Example of building your own grammar
	treesitter-haxe-grammar = pkgs.tree-sitter.buildGrammar {
		language = "haxe";
		version = "0.0.0+12e814c";
		src = pkgs.fetchFromGitHub {
			owner = "vantreeseba";
			repo = "tree-sitter-haxe";
			rev = "12e814cd9b0656b0eaa3e04b0036b3b6625cc0d7";
			hash = "sha256-MHZemYMpfbo1AdVUQv3j6eVWntZKi6K7UtRCPGk2kvE=";
		};
		meta.homepage = "https://github.com/vantreeseba/tree-sitter-haxe.git";
	};

in
	{
	plugins = {
		treesitter = {
			enable = true;
			settings.highlight.enable = true;
			settings.indent.enable = true;
			grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars ++ [
				treesitter-haxe-grammar
			];
			luaConfig.post=
				''
					do
						local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
						-- change the following as needed
						parser_config.haxe = {
							install_info = {
								url = "${treesitter-haxe-grammar}", -- local path or git repo
								files = {"src/parser.c", "src/scanner.c"}, 
							},
							filetype = "haxe", -- if filetype does not match the parser name
						}
					end
				'';
		};

		lsp = {
			postConfig = ''
				require('lspconfig').haxe_language_server.setup({
					cmd = {"${pkgs.nodejs}/bin/node", "/home/jaimek/dotfiles/custom_flakes/haxe/server.js"},
					init_options = {
						displayArguments = { "compile.hxml" },
					},
				})
				'';
		};
	};

	# Add as extra plugins so that their `queries/{language}/*.scm` get
	# installed and can be picked up by `tree-sitter`
	extraPlugins = [
		treesitter-haxe-grammar
	];
	extraFiles = {
		"queries/haxe/highlights.scm".text = builtins.readFile "${treesitter-haxe-grammar}/queries/highlights.scm";
		"queries/haxe/tags.scm".text = builtins.readFile "${treesitter-haxe-grammar}/queries/tags.scm";
		"queries/haxe/locals.scm".text = builtins.readFile "${treesitter-haxe-grammar}/queries/locals.scm";
		"queries/haxe/folds.scm".text = builtins.readFile "${treesitter-haxe-grammar}/queries/folds.scm";
		"queries/haxe/injections.scm".text = builtins.readFile "${treesitter-haxe-grammar}/queries/injections.scm";
	};

	filetype.extension.hx = "haxe";

	keymaps = [
		{
			mode = "n";
			key = "<leader>gp";
			action = ":!haxe compile.hxml && hl build/game.hl<cr>";
		}
		{
			mode = "n";
			key = "<leader>go";
			action = ":!haxe compile.hxml<cr>";
		}
		{
			mode = "n";
			key = "<leader>gi";
			action = ":!hl build/game.hl<cr>";
		}

	];

}
