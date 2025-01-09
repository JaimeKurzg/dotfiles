{
	description = "haxe-language-server";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		haxe-language-server.url = "github:vshaxe/haxe-language-server";
		haxe-language-server.flake = false;
	};

	outputs = { self, nixpkgs, haxe-language-server}: 
		let 
			pkgs = nixpkgs.legacyPackages.x86_64-linux;

			packageLock = builtins.fromJSON (builtins.readFile (haxe-language-server + "/package-lock.json"));

			deps = builtins.attrValues (removeAttrs packageLock.packages [ "" ])
				++ builtins.attrValues (removeAttrs packageLock.dependencies [ "" ]);


			tarballs = map (p: pkgs.fetchurl { url = p.resolved; hash = p.integrity; }) deps;

			tarballsFile = pkgs.writeTextFile {
				name = "tarballs";
				text = builtins.concatStringsSep "\n" tarballs;
			};


		in
			{
			packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
				inherit (packageLock) name version;
				src = haxe-language-server;
				buildInputs = [
					pkgs.nodejs
				];


				buildPhase = ''
					export HOME=$PWD/.home
					export npm_config_cache=$PWD/.npm
					mkdir -p $out/js
					cd $out/js
					cp -r $src/. .

					while read package
					do
					echo "caching $package"
					npm cache add "$package"
					done <${tarballsFile}

					npm ci
				'';

					# npx lix run vshaxe-build -t language-server
				installPhase = ''
					ln -s $out/js/node_modules/.bin $out/bin
				'';


			};
		};


}
