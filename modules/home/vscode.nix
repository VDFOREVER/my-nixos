{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.vscode;
in
{
    options.vscode = {
        enable = mkEnableOption "Enable vscode";
        extensions = mkEnableOption "Enable extensions";
    };

    config = mkIf cfg.enable {
        programs.vscode = {
            enable = true;
            extensions = mkIf cfg.extensions (with pkgs.vscode-extensions; [
                ms-vscode.cmake-tools
                ms-vscode.cpptools
                twxs.cmake
                pkief.material-icon-theme
                bbenoist.nix
                enkia.tokyo-night
            ]);
        };
    };
}