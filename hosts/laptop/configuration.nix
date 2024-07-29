# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, inputs, hostname, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			../../nixosModules/location.nix
			../../nixosModules/sysadmin.nix
			../../nixosModules/i3.nix
			../../nixosModules
		];

	programs.dconf.enable = true;

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	virtualisation.libvirtd.enable = true;

	boot.initrd.luks.devices."luks-2409d42b-f61b-4c96-9bb3-a57d088c653e".device = "/dev/disk/by-uuid/2409d42b-f61b-4c96-9bb3-a57d088c653e";
	networking.hostName = hostname; # Define your hostname.

	networking.networkmanager.enable = true;

	programs.nm-applet.enable = true;
	
	environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

# nix.settings = {
#     substituters = ["https://nix-gaming.cachix.org"];
#     trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
#   };

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		htop
		feh
		gnome.cheese
		gimp
		lutris

		github-desktop
		inkscape

		unstable.nh
		gnome.gnome-boxes
		nixos-shell
	];
	boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
	services.libinput = {
		enable = true;
		touchpad = {
			clickMethod = "clickfinger";
			tapping = true;
			tappingDragLock = false;
			tappingButtonMap = "lrm";
		};
	};

	hardware.uinput.enable = true;
	users.groups.uinput.members = [ "jaimek" ];
	users.groups.input.members = [ "jaimek" ];

	programs.evince.enable = true;

	programs.steam.enable = true;

	system.stateVersion = "23.11"; # Did you read the comment?
}
