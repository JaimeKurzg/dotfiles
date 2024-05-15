# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ hostname, unstable, config, pkgs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
			../../nixosModules/location.nix
			../../nixosModules/sysadmin.nix
			../../nixosModules/syncthing.nix
			../../nixosModules/i3.nix
		];

	nixpkgs.config.allowUnfree = true;

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = hostname; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

		networking.networkmanager.enable = true;

	programs.firefox.enable = true;

	system.stateVersion = "23.11"; 

}
