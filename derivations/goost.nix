{pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
	pname = "Goost";
	version = "1.2";
	src = pkgs.fetchzip {
		url = "https://github.com/goostengine/goost/releases/download/1.2-stable%2B3.4.1/Godot_v3.4.1-stable.goost_v1.2-stable_x11.64.zip";
		hash = "sha256-5xrvVSGwUkwXDFSCrCwkJUtk3bkKeri9BRtdGWTjzTA=";
	};
	system = "x86_64-linux";

	installPhase = ''
		mkdir -p $out/bin
		cp Godot_v3.4.1-stable.goost_v1.2-stable_x11.64 $out/bin/goost
		chmod +x $out/bin/goost
		'';
}
