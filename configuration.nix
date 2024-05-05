# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, inputs, ... }:
{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			./nixosModules
		];
	programs.dconf.enable = true;

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	virtualisation.libvirtd.enable = true;

	boot.initrd.luks.devices."luks-2409d42b-f61b-4c96-9bb3-a57d088c653e".device = "/dev/disk/by-uuid/2409d42b-f61b-4c96-9bb3-a57d088c653e";
	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Enable network manager applet
	programs.nm-applet.enable = true;

# Set your time zone.
	time.timeZone = "America/Denver";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	
	environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
	enable = true;
		pulse.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
	};

	users.users.jaimek = {
		isNormalUser = true;
		description = "Jaime Kurzweg";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			discord
		];
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	nix.package = pkgs.nixFlakes;
	nix.settings.experimental-features=["nix-command" "flakes"];

nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

environment.sessionVariables = {
	FLAKE = "/home/jaimek/.dotfiles";
};

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		neovim
		kitty
		pulseaudioFull # allows for increase and decrease sound
		playerctl
		brightnessctl
		git
		git-credential-manager
		pass
		gnupg
		pinentry
		pinentry-curses
		pass-git-helper

		htop
		ranger
		unzip
		pavucontrol
		feh
		gnome.cheese
		gimp
		lutris
		unstable.jujutsu

		github-desktop
		inkscape

		unstable.nh
		cinnamon.nemo
		gnome.gnome-boxes
	];

	programs.steam.enable = true;
	programs.gnupg = {
		agent = {
			enable = true;
			pinentryFlavor = "curses";
		};

	};

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?

}
