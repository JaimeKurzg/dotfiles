{pkgs}:

pkgs.writeShellApplication {
	name = "godot-nvim";
	runtimeInputs = [ pkgs.kitty pkgs.wmctrl ];
	text = ''
		file=''$1
		project=''$2
		col=''$3
		line=''$4
		if eval wmctrl -l | grep -q "godot-nvim"; then 
			nvim --server /tmp/godot.pipe --remote-send "<esc>:n ''$file<CR>:call cursor(''$line,''$col)<CR>" 
			wmctrl -a godot-nvim
		else
			cd "''$project"
			kitty --title godot-nvim -e vim +"$line" "$file"
		fi
	'';
}
