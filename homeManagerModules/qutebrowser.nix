{ config, pkgs, ... }:

{
	programs.qutebrowser = {
		enable = true;

		
		extraConfig = ''
c.input.insert_mode.leave_on_load = true
extraConfig = "config.load_autoconfig(false)
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
