{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = { self, nixpkgs }: {

		haxe-language-server = nixpkgs.stdenv.mkDerivation {
			pname = "haxe-language-server";
			version = "900c057";
			src = nixpkgs.fetchFromGitHub {
				owner = "vshaxe";
				repo = "haxe-language-server";
				rev = "900c0570372f8f592724b25ac52ababe1ef5717";
				hash = "sha256-7bg7/3drvQfxw8Kq0CUhtti8jad+2XID28y6Ucpkd6k";
			};

			buildInputs = [
				nixpkgs.nodejs
			];

			buildPhase = ''
			npm ci
			npx lix run vshaxe-build -t language-server
			'';



		};


	};
}
