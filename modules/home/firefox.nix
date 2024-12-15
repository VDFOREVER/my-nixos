{inputs, pkgs, config, lib, ...}: 
with lib;
let
  cfg = config.firefox;
in
{
    options.firefox = {
        enable = mkEnableOption "Enable firefox";
    };

    config = mkIf cfg.enable {
        programs.firefox = {
            enable = true;
            package = pkgs.firefox-bin;
            profiles.svd = {
                extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
                    ublock-origin
                    sponsorblock
                    darkreader
                    youtube-shorts-block
                    privacy-badger
                ];
            };
        };
    };
}