{
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
				"waybar"
				"hypridle"
				"hyprpaper"
				"nekoray"
				"telegram-desktop"
				"systemctl start --user polkit-gnome-authentication-agent-1"
			];

			env = [
				"env = HYPRCURSOR_THEME,capitaine-cursors"
				"env = HYPRCURSOR_SIZE,24"
				"env = QT_STYLE_OVERRIDE,kvantum"
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
				sensitivity = 0;
			};

			general = {
				gaps_in = 5;
				gaps_out = 10;
				border_size = 1;
				"col.active_border" = "rgba(5e6574ff)";
				"col.inactive_border" = "rgba(272a34ff)";

				layout = "dwindle";
				allow_tearing = false;
				no_border_on_floating = true;
			};

			decoration = {
				rounding = 5;

				blur = {
					enabled = true;
					size = 5;
					passes = 1;
				};

				drop_shadow = true;
				shadow_range = 4;
				shadow_render_power = 3;
				"col.shadow" = "rgba(1a1a1aee)";
			};

			animations = {
				enabled = true;
				bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

				animation = [
					"windows,     1, 5,  myBezier"
					"windowsOut,  1, 5,  default, popin 80%"
					"border,      1, 10, default"
					"borderangle, 1, 8,  default"
					"fade,        1, 5,  default"
					"workspaces,  1, 4,  default"
				];
			};

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

				"$mainMod ALT, h, moveactive, 50 0"
				"$mainMod ALT, l, moveactive, -50 0"
				"$mainMod ALT, k, moveactive, 0 -50"
				"$mainMod ALT, j, moveactive, 0 50"

				"$mainMod CTRL, h, resizeactive,-50 0"
				"$mainMod CTRL, l, resizeactive,50 0"
				"$mainMod CTRL, k, resizeactive,0 -50"
				"$mainMod CTRL, j, resizeactive,0 50"

				"$mainMod, h, movefocus, l"
				"$mainMod, l, movefocus, r"
				"$mainMod, k, movefocus, u"
				"$mainMod, j, movefocus, d"
			];

			bindm = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];
		};
	};
}
