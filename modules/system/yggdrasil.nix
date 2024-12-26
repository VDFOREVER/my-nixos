{ config, lib, pkgs, ...}:
with lib;
let
  cfg = config.yggdrasil;
in
{
    options.yggdrasil = {
        enable = mkEnableOption "Enable yggdrasil netword";
    };
    config = mkIf cfg.enable {
      services.yggdrasil = {
          enable = true;
          persistentKeys = true;
          openMulticastPort = true;
          settings = {
              Peers = ["tcp://ygg.mkg20001.io:80"];
              Listen = [];
          };
      };
    };
}