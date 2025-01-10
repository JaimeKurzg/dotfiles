{ config, unstable, lib, ... }:

{
	options = {
		qutebrowser.enable = lib.mkEnableOption "enables qutebrowser";
	};
	config = lib.mkIf config.qutebrowser.enable {
		nixpkgs.config.allowUnfree = true;
		nixpkgs.overlays = [
			(final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
		];
		programs.qutebrowser = {
			enable = true;
			package = unstable.qutebrowser;
			settings = {
				fonts.web.size.default = lib.mkForce 14;
			};
			# why do these need to be not indented?
			extraConfig = ''
config.load_autoconfig(False)
c.input.mode_override = "normal"
c.input.insert_mode.auto_load = True
c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.content.javascript.enabled = True
c.content.javascript.clipboard = "access"
c.content.pdfjs = True
				'';
			keyBindings = {
				normal = {
					"<space>j" = "selection-follow";
					"<ctrl-h>" = "tab-prev";
					"<ctrl-l>" = "tab-next";
					"J" = "tab-prev";
					"K" = "tab-next";
					"<ctrl-n>" = ''fake-key <Down>'';
					"<ctrl-p>" = "fake-key <Up>";
				};
				command = {
					"<ctrl-n>" = "completion-item-focus next";
					"<ctrl-p>" = "completion-item-focus prev";
				};
				insert = {
					"<ctrl-n>" = ''fake-key <Down>'';
					"<ctrl-p>" = "fake-key <Up>";
				};
			};
		};
	};
}
