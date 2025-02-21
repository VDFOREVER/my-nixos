{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.waybar;
in
 {
	options.waybar = {
    	enable = mkEnableOption "Enable waybar";
  	};

	config = mkIf cfg.enable {
		home.packages = with pkgs; [
			jq
		];

		programs.waybar = {
			enable = true;
			settings = {
				mainr = {
					position = "bottom";
					margin-bottom = 5;
					spacing = 0;
					height =  15;

					modules-left = ["custom/weather" "custom/pick" "custom/lock" "custom/poweroff"];
					modules-center = ["hyprland/workspaces"];
					modules-right = ["tray" "pulseaudio" "hyprland/language" "clock"];

					"custom/weather" = {
						format = "󰖞 {}";
						interval = 300;
						exec = "~/nix/other/weather.sh";
						tooltip = false;
					};

					"custom/pick" = {
						format = "󰈊";
						on-click = "wl-copy $(hyprpicker)";
						tooltip = false;
					};

					"custom/lock" = {
						format = "󰌋";
						on-click = "hyprlock";
						tooltip = false;
					};

					"custom/poweroff" = {
						format = "⏻";
						on-click = "shutdown now";
						tooltip = false;
					};

					"hyprland/workspaces" = {
						format = "{icon}";
						on-click = "activate";
						tooltip = false;
						all-outputs = true;
					};

					"tray" = {
						icon-size = 14;
						spacing = 15;
					};

					"pulseaudio" = {
						scroll-step = 5;
						format = "{icon}{volume}%";
						format-icons = {
							"default" = [" " " " " "];
						};
						on-click = "pavucontrol";
					};

					"hyprland/language" = {
						format = "{}";
						format-en = "EN";
						format-ru = "RU";
					};
					
					"clock" = {
						tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
						format-alt = "{:%Y-%m-%d}";
					};

					escape = true;
				# };
				};
			};

			style = 
		''
	* {
		font-family: 'Terminus (TTF)', SymbolsNerdFont;
		font-weight: bold;
		font-size: 14px;
		min-height: 0;
	}

	window#waybar {
		background-color: @bg;
		transition-property: background-color;
		transition-duration: .5s;
		border-radius: 0;
	}

	@define-color bg #282828;
	@define-color fg #E6D8B1; 
	@define-color black #242424;
	@define-color green #d65d0e;

	#custom-weather {
		background: @black;
		color: @fg;
		padding: 0 5px 0 10px;
		margin: 4px 0 4px 10px;
		border-radius: 6 0 0 6;
	}
	#custom-pick {
		background: @black;
		color: @fg;
		padding: 0;
		margin: 4px 0 4px 0;
		border-radius: 0;
	}
	#custom-lock {
		background: @black;
		color: @fg;
		padding: 0 5px 0 10px;
		margin: 4px 0 4px 0;
	}
	#custom-poweroff {
		background: @black;
		color: @fg;
		padding: 0 10px 0 5px;
		margin: 4px 0 4px 0;
		border-radius: 0 6 6 0;
	}

	#workspaces {
		background-color: @black;
		margin: 4px 5px 4px 5px;
		border-radius: 6;
	}
	#workspaces button {
		background-color: @black;
		color: @fg;	
		padding: 0 4px;
		margin: 2px 5px 0 5px;
		border-bottom: solid 2px #23252e;
		border-radius: 0;
	}
	#workspaces button:hover {
		background-color: @black;
		color: @fg;	
		padding: 0 4px;
		margin: 2px 5px 0 5px;
		border-bottom: solid 2px @fg;
		border-radius: 0;
	}
	#workspaces button.active {
		background-color: @black;
		color: @green;
		padding: 0 4px;
		margin: 2px 5px 0 5px;
		border-bottom: solid 2px;
		border-radius: 0;
	}
	#workspaces button.empty {
		color: @gr;
		padding: 0 4px;
		margin: 2px 5px 0 5px;
		border-bottom: solid 2px #23252e;
		border-radius: 0;
	}


	#tray {
		background: @black;
		color: @fg;
		padding: 0 15px 0 15px;
		margin: 4px 0 4px 0;
		border-radius: 6 0 0 6;
	}
	#pulseaudio{
		background: @black;
		color: @fg;
		padding: 0 30 0 15px;
		margin: 4px 0px 4px 0;
	}

	#language {
		background: @black;
		color: @green;
		padding: 0;
		margin: 4px 0 4px 0;
		border-bottom: solid 2px @green;
		border-radius: 0;
	}

	#clock {
		background: @black;
		color: @fg;
		padding: 0 15px 0 29px;
		margin: 4px 10px 4px 0;
		border-radius: 0 6 6 0;
		font-size: 14px;
	}
		'';
		};
	};
}