{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.vm;
in
{
    options.vm = {
        enable = mkEnableOption "Enable";
    };

    config = mkIf cfg.enable {
        users.users.svd.extraGroups = [ "libvirtd" ];
        environment.systemPackages = with pkgs; [virt-manager];

        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    swtpm.enable = true;
                    ovmf.enable = true;
                    ovmf.packages = [ pkgs.OVMFFull.fd ];
                };
            };
        };
    };
}