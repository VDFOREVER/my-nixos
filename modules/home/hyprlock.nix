{
    programs.hyprlock = {
        enable = true;
        settings = {
            background = [
                {
                    path = "~/nix/other/wallpaper.png";
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
                    font_family = "JetBrainsMono";
                    
                    position = "0, 20";
                    halign = "center";
                    valign = "center";
                }

                {
                    text = "cmd[update:1] echo $(date +\"%I:%M %p\")";
                    color = "rgba(200, 200, 200, 1.0)";
                    font_size = 25;
                    font_family = "JetBrains Mono Bold";

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
}