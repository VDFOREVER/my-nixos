{ config, lib, pkgs, ...}:
with lib;
let
  cfg = config.i2pd;
in
{
    options.i2pd = {
        enable = mkEnableOption "Enable yggdrasil netword";
    };

    config = mkIf cfg.enable {
        services.i2pd = {
            enable = true;
            proto = {
                http.enable = true;
                httpProxy.enable = true;
            };
        };
    };
}