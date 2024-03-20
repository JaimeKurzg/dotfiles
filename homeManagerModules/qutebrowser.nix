{ config, pkgs, ... }:

{
	programs.qutebrowser = {
		enable = true;

		
		extraConfig = ''
config.load_autoconfig(False)
c.input.mode_override = "normal"
		'';
		keyBindings = {
			command = {
				"<space>j" = "selection-follow";
				"J" = "tab-prev";
				"K" = "tab-next";
				"<ctrl-n>" = "completion-item-focus next";
				"<ctrl-p>" = "completion-item-focus prev";
			};
		};
	};
}
