
{
	extraConfigVim = ''

		tnoremap <Esc> <C-\><C-n>
		tnoremap <C-h> <C-\><C-n><C-w>h
		tnoremap <C-j> <C-\><C-n><C-w>j
		tnoremap <C-k> <C-\><C-n><C-w>k
		tnoremap <C-l> <C-\><C-n><C-w>l
		tnoremap <C-n> <C-\><C-n>:e#<CR>


		" Terminal bindings
		nnoremap <silent> <leader>tt :terminal<CR>
		nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
		nnoremap <silent> <leader>th :new<CR>:terminal<CR>

			'';
	keymaps = [
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
			key = "<leader>s";
			action = '':%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>'';
		}
		# {
		# 	mode = "n";
		# 	key = "<leader>x";
		# 	action = "<cmd>!chmod +x %<CR>";
		# 	options = { silent = true; };
		# }
		{
			mode = "n";
			key = "=a";
			action = "mzgg=G'zzz";
		}
		{
			mode = "i";
			key = "<C-BS>";
			action = "<C-o>dB<C-o>x";
		}
		{
			mode = "n";
			key = "<C-BS>";
			action = "dBx";
		}

	];
}
