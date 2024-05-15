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
	];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
	unstable.atlauncher
	unstable.prismlauncher
	lutris
	];


# gnome stuff
environment.gnome.excludePackages = (with pkgs; [
  # for packages that are pkgs.***
  gnome-tour
  gnome-connections
  xterm
]) ++ (with pkgs.gnome; [
  # for packages that are pkgs.gnome.***
  epiphany # web browser
  geary # email reader
  evince # document viewer
]);

  nixpkgs.overlays = [
	  (final: prev: {
	   gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
			   mutter = gnomePrev.mutter.overrideAttrs ( old: {
					   src = pkgs.fetchgit {
					   url = "https://gitlab.gnome.org/vanvugt/mutter.git";
					   rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
					   sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
					   };
					   });
			   });
	   })
  ];


	programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;


  programs.firefox.enable = true;

  system.stateVersion = "23.11"; 

}
