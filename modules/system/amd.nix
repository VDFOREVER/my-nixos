{ config, lib, pkgs, ...}:
with lib;
let
  cfg = config.amdgpu;
in
{
  options.amdgpu = {
    enable = mkEnableOption "Enable AMDGPU stuff";
  };
  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}