{ config, pkgs, lib, ... }:

{
	programs.qutebrowser = {
		enable = true;

		
		settings = {

			fonts.web.size.default = lib.mkForce (14);
		};
		extraConfig = ''
config.load_autoconfig(False)
c.input.mode_override = "normal"
		'';
		keyBindings = {
			normal = {
				"<space>j" = "selection-follow";
				"<ctrl-h>" = "tab-prev";
				"<ctrl-l>" = "tab-next";
				"J" = "tab-prev";
				"K" = "tab-next";
			};
			command = {
				"<ctrl-n>" = "completion-item-focus next";
				"<ctrl-p>" = "completion-item-focus prev";
			};
		};
	};
}
