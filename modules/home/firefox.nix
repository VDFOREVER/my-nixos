{inputs, pkgs, ...}: {
    programs.firefox = {
        enable = true;
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
}