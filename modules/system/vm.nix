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
        environment.systemPackages = with pkgs; [ virt-manager ];

        systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

        virtualisation = {
            spiceUSBRedirection.enable = true;
            libvirtd = {
                enable = true;
                onShutdown = "shutdown";
                qemu = {
                    package = pkgs.qemu_kvm;
                    runAsRoot = true;
                    swtpm.enable = true;
                    ovmf = {
                        enable = true;
                        packages = [(pkgs.OVMF.override {
                            secureBoot = true;
                            tpmSupport = true;
                        }).fd];
                    };
                };
            };
        };
    };
}
