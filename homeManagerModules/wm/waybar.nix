{config, pkgs, lib, ...}:
{
  programs.waybar.enable = true;
   
  programs.waybar.settings = {
  mainBar = {
    layer = "top";
    position = "bottom";
    height = 24;
    output = [
      "eDP-1"
    ];

    modules-left = [ "sway/workspaces" ];
    modules-right = [ "clock" "battery" ];
    
    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      persistent_workspaces = {
        "1" = []; 
      };
      disable-click = true;
    };
    
    "clock" = {
      interval = 60;
      format = "{:%a %d/%m %I:%M}";
    };

    "battery" = {
      tooltip = false;
    };
  };
  };

  programs.waybar.style = ''
  
  * {
    border: none;
    border-radius: 0;
    padding: 0;
    margin: 0;

	font-family: OpenDyslexicM;
    font-size: 18px;
  }

  window#waybar {
    background: #292828;
    color: #ffffff;
  }
  
  #workspaces button {
    margin-right: 10px;
    color: #${config.lib.stylix.colors.base05};
  }
  #workspaces button:hover, #workspaces button:active {
    background-color: #292828;
    color: #${config.lib.stylix.colors.base05};
  }
  #workspaces button.focused {
    background-color: #383737;
  }
	#battery {
		padding-right: 7px;
	}
  '';
}
