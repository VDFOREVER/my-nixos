{ pkgs, ...}: {
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            ms-vscode.cmake-tools
            ms-vscode.cpptools
            pkief.material-icon-theme
            bbenoist.nix
            enkia.tokyo-night
        ];
    };
}