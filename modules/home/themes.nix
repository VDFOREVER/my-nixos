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
            package = pkgs.capitaine-cursors-themed;
            name = "Capitaine Cursors (Gruvbox)";
            size = 24;
            x11.enable = true;
            gtk.enable = true;
        };
        gtk = {
            enable = true;
            iconTheme = {
                package = pkgs.gruvbox-plus-icons;
                name = "Gruvbox-Plus-Dark";
            };
            theme = {
                package = pkgs.gruvbox-gtk-theme.override { tweakVariants = [ "medium" ]; };
                name = "Gruvbox-Dark-Medium";
            };
            cursorTheme = {
                package = pkgs.capitaine-cursors-themed;
                name = "Capitaine Cursors (Gruvbox)";
            };
            font.name = "Terminus (TTF)";
            font.size = 12;
        };

        qt = {
            enable = true;
            platformTheme.name = "gtk"; 
        };
    };
}
