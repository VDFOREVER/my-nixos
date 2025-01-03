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
        users.users.svd.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" ];
        environment.systemPackages = with pkgs; [ virt-manager ];

        boot = {
            kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "modconf" ];
            initrd.kernelModules = [ "amdgpu" ];    # возвращает видео после загрузки системы
            extraModprobeConfig = "options vfio-pci ids=1002:67df,1002:aaf0";
        };

        systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

        virtualisation = {
            spiceUSBRedirection.enable = true;
            libvirtd = {
                enable = true;
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
