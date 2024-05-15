{pkgs, ...}:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


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
}
