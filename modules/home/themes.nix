{ config, pkgs, lib, ... }: 
with lib;
let
  cfg = config.theming;
in
{
    options.theming = {
        enable = mkEnableOption "Enable theming stuff like cursor theme, icon theme and etc";
    };

    config = mkIf cfg.enable {
        home.pointerCursor = {
            package = pkgs.capitaine-cursors;
            name = "capitaine-cursors";
            size = 24;
            x11.enable = true;
            gtk.enable = true;
        };

        gtk = {
            enable = true;
            iconTheme = {
                name = "Flat-Remix-Black-Dark";
                package = pkgs.flat-remix-icon-theme;
            };
            theme = {
                package = pkgs.flat-remix-gtk;
                name = "Flat-Remix-GTK-Grey-Dark";
            };
            cursorTheme = {
                package = pkgs.capitaine-cursors;
                name = "capitaine-cursors";
            };
            font.name = "JetBrainsMono";
        };

        qt = {
            enable = true;
            platformTheme.name = "gtk"; 
        };
    };
}
