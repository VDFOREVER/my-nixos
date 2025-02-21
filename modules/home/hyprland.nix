{config, pkgs, lib, ...}: 
with lib;
let
  cfg = config.hyprland;
in
{
	options.hyprland = {
    	enable = mkEnableOption "Enable my Hyprland configuration";
    	hyprpaper = mkEnableOption "Enable image wallpapers with hyprpaper";
    	hyprlock = mkEnableOption "Enable locking program";
		hypridle = mkEnableOption "Enable hypridle";
		wofi = mkEnableOption "Enable wofi";
		mako = mkEnableOption "Enable mako";
		alacritty = mkEnableOption "Enable alacritty";
  	};

	config = mkIf cfg.enable {
		xdg.portal = {
			enable = true;
			extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
			config.common.default = "*";
		};

		systemd.user.services.polkit_gnome = {
			Install = {
				WantedBy = [ "graphical-session.target" ];
			};
			Service = {
				Type = "exec";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
			};
		};

		home.packages = with pkgs; [
			hypridle
			hyprpaper
			hyprpicker
			hyprcursor
			hyprlock
			grim
			grimblast
			slurp
			swappy
			mako
			libnotify
			wl-clipboard
			xdg-utils
		];

		services.mako = mkIf cfg.mako {
			enable = true;
			layer = "overlay";
			ignoreTimeout = true;
			defaultTimeout = 4000;
			font = "Terminus (TTF)";
			padding = "7";
			backgroundColor = "#282828";
			borderColor = "#d65d0e";
			borderRadius = 0;
		};

		programs.alacritty = mkIf cfg.alacritty {
			enable = true;
			settings = {
				window = {
					padding = {
						x = 15;
						y = 15;
					};
				};

				font = {
					size = 12.0;
					normal.family = "Terminus (TTF)";
				};

				colors = {
					primary = {
						background = "#282828";
						foreground = "#ebdbb2";
					};

					normal = {
						black   = "#282828";
						red     = "#cc241d";
						green   = "#98971a";
						yellow  = "#d79921";
						blue    = "#458588";
						magenta = "#b16286";
						cyan    = "#689d6a";
						white   = "#a89984";
					};

					cursor = {
						cursor = "CellForeground";
						text = "CellBackground";
					};

					bright = {
						black   = "#928374";
						red     = "#fb4934";
						green   = "#b8bb26";
						yellow  = "#fabd2f";
						blue    = "#83a598";
						magenta = "#d3869b";
						cyan    = "#8ec07c";
						white   = "#ebdbb2";
					};
				};
			};
		};

		programs.wofi = mkIf cfg.wofi {
			enable = true;
			settings = {
				height = 270;
				width = 450;

				no_actions = true;
				hide_scroll = true;

				image_size = 20;
				prompt = "search";
				term = "alacritty";
			};

			style = ''
				*{
					font-family: 'Terminus (TTF)';
					font-size: 14px;
				}
				@define-color bg #282828;
				@define-color fg #f9f9f9;
				@define-color green #2be491;
				@define-color gr #4A4841;
				@define-color black #4A4841;
				@define-color bgb #d65d0e

				window {
					background-color: @bg;
					border-radius: 6px;
					border: 2px solid @bgb;
					color: @bg;
				}
				#input {
					margin: 10 0 10 0x;
					padding: 1;
					border-radius: 5px;
					border: none;
					border-bottom: 0px solid @fg;
					background-color: @gr;
					color: @fg;
				}
				#inner-box {
					background-color: @bg;
					padding: 15 0 0 0;
				}
				#outer-box {
					margin: 20px;
					padding: 0px;
					background-color: @bg;
				}
				#text {
					padding: 8px;
					margin: 2px;
					color: @fg;
				}
				#entry {
					background-color: @bg;
					padding: 0 15px;
				}
				#entry:nth-child(even){
					background-color: @bg;
					padding: 0 15px;
				}
				#entry:selected {
					border-radius: 5px;
					background-color: @gr;
				}
				#text:selected {
					color: @fg;
				}
			'';
		};

		services.hyprpaper = mkIf cfg.hyprpaper {
			enable = true;
			settings = {
				splash = false;

				preload = "~/nix/other/wp.png";
				wallpaper = ",~/nix/other/wp.png";
			};
		};

		services.hypridle = mkIf cfg.hypridle {
			enable = true;
			settings = {
				general = {
					lock_cmd = "pidof hyprlock || hyprlock";
					before_sleep_cmd = "loginctl lock-session"; 
				};

				listener = [
					{
						timeout = 400;
						on-timeout = "hyprlock";
					}
				];
			};
    	};

		programs.hyprlock = mkIf cfg.hyprlock {
			enable = true;
			settings = {
				background = [
					{
						path = "~/nix/other/wp.png";
						color = "rgba(25, 20, 20, 1.0)";
						blur_passes = 2;
						blur_size = 2;
						noise = 0.0117;
						contrast = 0.8916;
						brightness = 0.8172;
						vibrancy = 0.1696;
						vibrancy_darkness = 0.0;
					}
				];

				label = [
					{
						text = "Hi <span foreground='##1692D0'>$USER</span> :)";
						color = "rgba(200, 200, 200, 1.0)";
						font_size = 25;
						font_family = "Terminus (TTF)";
						
						position = "0, 20";
						halign = "center";
						valign = "center";
					}

					{
						text = "cmd[update:1] echo $(date +\"%I:%M %p\")";
						color = "rgba(200, 200, 200, 1.0)";
						font_size = 25;
						font_family = "Terminus (TTF) Bold";

						position = "0, 250";
						halign = "center";
						valign = "center";
					}
				];

				input-field = [
					{
						size = "200, 50";
						outline_thickness = 3;
						dots_size = 0.33;
						dots_spacing = 0.15;
						dots_center = false;
						dots_rounding = -1;
						outer_color = "rgb(151515)";
						inner_color = "rgb(200, 200, 200)";
						font_color = "rgb(10, 10, 10)";
						fade_on_empty = true;
						fade_timeout = 1000;
						placeholder_text = "<i>Input Password...</i>";
						hide_input = false;
						rounding = -1;
						check_color = "rgb(204, 136, 34)";
						fail_color = "rgb(204, 34, 34)";
						fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
						fail_transition = 300;
						capslock_color = -1;
						numlock_color = -1;
						bothlock_color = -1;
						invert_numlock = false;

						position = "0, -60";
						halign = "center";
						valign = "center";
					}
				];
			};
		};

	wayland.windowManager.hyprland = {
			enable = true;
			xwayland.enable = true;

			settings = {
				"$mainMod" = "L_ALT";

				monitor = [
					"HDMI-A-1,1920x1080,0x0,auto"
					"HDMI-A-2,1600x900,1920x0,auto"
				];

				exec-once = [
					"firefox"
					"mako"
					"hypridle"
					"hyprpaper"
					"telegram-desktop"
					"gnome-keyring-daemon"
					"waybar"
				];

				env = [
					"env = HYPRCURSOR_THEME,capitaine-cursors"
					"env = HYPRCURSOR_SIZE,24"
					"env = XDG_CURRENT_DESKTOP,Hyprland"
					"env = XDG_SESSION_TYPE,wayland"
					"env = XDG_SESSION_DESKTOP,Hyprland"
					"env = QT_AUTO_SCREEN_SCALE_FACTOR,1"
					"env = QT_QPA_PLATFORM,wayland"
				];

				input = {
					kb_layout = "us,ru";
					kb_options = "grp:caps_toggle";
					follow_mouse = 1;
					
					sensitivity = 0.5;
				};

				general = {
					gaps_in = 5;
					gaps_out = 10;
					border_size = 2;
					"col.active_border" = "rgba(d65d0eff)";
					"col.inactive_border" = "rgba(3c3836ff)";

					layout = "dwindle";
					allow_tearing = false;
					no_border_on_floating = false;
				};

				decoration = {
					rounding = 0;
					blur.enabled = false;
					shadow.enabled = false;
				};
		
				animations.enabled = false;
				dwindle = {
					pseudotile = true;
					preserve_split = true;
				};

				master.new_status = "master";
				gestures.workspace_swipe = false;
				misc.force_default_wallpaper = false;

				bind = [
					"$mainMod, T, exec, alacritty"
					"$mainMod, E, exec, nemo"
					"$mainMod, R, exec, wofi --show drun -I"
					"$mainMod, C, killactive"
					"$mainMod, M, exit"
					"$mainMod, V, togglefloating,"
					"$mainMod, f, fullscreen,"
					", print, exec, ~/nix/other/screenshot.sh sf"

					# Switch workspaces with mainMod + [0-9]
					"$mainMod, 1, workspace, 1"
					"$mainMod, 2, workspace, 2"
					"$mainMod, 3, workspace, 3"
					"$mainMod, 4, workspace, 4"
					"$mainMod, 5, workspace, 5"
					"$mainMod, 6, workspace, 6"
					"$mainMod, 7, workspace, 7"
					"$mainMod, 8, workspace, 8"
					"$mainMod, 9, workspace, 9"
					"$mainMod, 0, workspace, 10"

					# Move active window to a workspace with mainMod + SHIFT + [0-9]
					"$mainMod SHIFT, 1, movetoworkspace, 1"
					"$mainMod SHIFT, 2, movetoworkspace, 2"
					"$mainMod SHIFT, 3, movetoworkspace, 3"
					"$mainMod SHIFT, 4, movetoworkspace, 4"
					"$mainMod SHIFT, 5, movetoworkspace, 5"
					"$mainMod SHIFT, 6, movetoworkspace, 6"
					"$mainMod SHIFT, 7, movetoworkspace, 7"
					"$mainMod SHIFT, 8, movetoworkspace, 8"
					"$mainMod SHIFT, 9, movetoworkspace, 9"
					"$mainMod SHIFT, 0, movetoworkspace, 10"

					"$mainMod SHIFT, h, movewindow, l"
					"$mainMod SHIFT, l, movewindow, r"
					"$mainMod SHIFT, k, movewindow, u"
					"$mainMod SHIFT, j, movewindow, d"

					"$mainMod, h, movefocus, l"
					"$mainMod, l, movefocus, r"
					"$mainMod, k, movefocus, u"
					"$mainMod, j, movefocus, d"

					"$mainMod CTRL, h, moveactive, -50 0"
					"$mainMod CTRL, l, moveactive, 50 0"
					"$mainMod CTRL, k, moveactive, 0 -50"
					"$mainMod CTRL, j, moveactive, 0 50"

					"$mainMod SUPER, h, resizeactive,-50 0"
					"$mainMod SUPER, l, resizeactive,50 0"
					"$mainMod SUPER, k, resizeactive,0 -50"
					"$mainMod SUPER, j, resizeactive,0 50"
				];

				bindm = [
					"$mainMod, mouse:272, movewindow"
					"$mainMod, mouse:273, resizewindow"
				];
			};
		};
	};
}