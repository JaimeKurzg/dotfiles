{ config, pkgs, lib, ... }:

{
	options = {
		qutebrowser.enable = lib.mkEnableOption "enables qutebrowser";
	};
	config = lib.mkIf config.qutebrowser.enable {
		programs.qutebrowser = {
			enable = true;
			settings = {
				fonts.web.size.default = lib.mkForce (14);
			};
			extraConfig = ''
config.load_autoconfig(False)
c.input.mode_override = "normal"
c.content.javascript.enabled = True
c.content.javascript.clipboard = "access"
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
	};
}
