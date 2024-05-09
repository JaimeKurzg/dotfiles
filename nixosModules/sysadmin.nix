{unstable, pkgs, lib, config, ...}:
{
	imports = [
	];

	nixpkgs.config.allowUnfree = true;
	nix.package = pkgs.nixFlakes;
	nix.settings.experimental-features=["nix-command" "flakes"];

	services.printing.enable = true;

	sound.enable = true;
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

			cinnamon.nemo
			unzip
			unstable.nh

			# (pkgs.stdenv.mkDerivation {
			# 	name = "GK6X";
			# 	src = pkgs.fetchFromGitHub {
			# 		owner = "pixeltris";
			# 		repo = "GK6X";
			# 		rev = "4ce22cabf46d75b7e2e662c17f9f2e24100a90a3";
			# 		hash = "sha256-za8CHEVh8mX1hRzNNouS+tLSDHDnJrBT3JnX+tFa4hs=";
			# 		};
			# 	})
	];

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	services.openssh = {
		enable = true;
	};
	environment.sessionVariables = { 
		FLAKE = "/home/jaimek/dotfiles/";
	};

}
