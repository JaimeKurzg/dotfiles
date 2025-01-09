{unstable, pkgs, lib, config, ...}:
{
	imports = [
	];

	nixpkgs.config.allowUnfree = true;
	# nix.package = pkgs.nixFlakes;
	nix.settings.experimental-features=["nix-command" "flakes"];

	services.printing.enable = true;

	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.jaimek = {
		isNormalUser = true;
		description = "Jaime Kurzweg";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
		];
	};

	environment.systemPackages = with pkgs; [
		neovim
		kitty
		pulseaudioFull # allows for increase and decrease sound
		playerctl
		brightnessctl
		git
		pavucontrol

		unzip
		unstable.nh

	];

	programs.thunar = {
		plugins = with pkgs.xfce; [
			thunar-archive-plugin
			thunar-volman
			thunar-media-tags-plugin
		];
		enable = true;
	};
	programs.file-roller.enable = true;
	services.tumbler.enable = true; # Thumbnail support for images

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	services.openssh = {
		enable = true;
	};
	environment.sessionVariables = { 
		FLAKE = "/home/jaimek/dotfiles/";
	};

}
