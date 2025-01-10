{pkgs, config, ...}:{
	extraPlugins = [
		{
			plugin = (pkgs.vimUtils.buildVimPlugin {
				name = "colorizer";
				src = pkgs.fetchFromGitHub {
					owner = "norcalli";
					repo = "nvim-colorizer.lua";
					rev = "a065833f35a3a7cc3ef137ac88b5381da2ba302e";
					hash = "sha256-gjO89Sx335PqVgceM9DBfcVozNjovC8KML1OZCRNMGw=";
				};
			});
		}
	];
	extraConfigLuaPost = ''
		require'colorizer'.setup()
	'';
}
