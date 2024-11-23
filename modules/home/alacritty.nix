{
    programs.alacritty = {
        enable = true;
        settings = {
            window = {
                opacity = 0.8;
                padding = {
                    x = 15;
                    y = 15;
                };
            };

            font = {
                size = 10.0;
                normal = {
                    family = "JetBrains Mono";
                    style = "Bold";
                };
            };

        colors = {
            primary = {
                background = "#272a34";
                foreground = "#f9f9f9";
            };

            normal = {
                black = "#3b4252";
                blue = "#81a1c1";
                cyan = "#88c0d0";
                green = "#a3be8c";
                magenta = "#b48ead";
                red = "#bf616a";
                white = "#e5e9f0";
                yellow = "#ebcb8b";
            };

            cursor = {
                cursor = "CellForeground";
                text = "CellBackground";
            };

            bright = {
                black = "#4c566a";
                blue = "#81a1c1";
                cyan = "#8fbcbb";
                green = "#a3be8c";
                magenta = "#b48ead";
                red = "#bf616a";
                white = "#eceff4";
                yellow = "#ebcb8b";
            };
        };
    };
  };
}