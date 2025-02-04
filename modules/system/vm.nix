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

        boot = {
            kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
            kernelParams = [ "amd_iommu=on" "iommu=pt" ];
        };

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
                    verbatimConfig = ''
                        user = "svd"
                        group = "kvm"
                    '';
                };
                extraConfig = ''
                    unix_sock_group = "libvirtd"
                    unix_sock_rw_perms = "0770"
                '';
            };
        };

        system.activationScripts.libvirt-hooks.text = "ln -Tfs /etc/libvirt/hooks /var/lib/libvirt/hooks";

        environment.etc = {
            "libvirt/hooks/qemu" = {
            text = ''
                    #!/run/current-system/sw/bin/bash
            
                    GUEST_NAME="$1"
                    HOOK_NAME="$2"
                    STATE_NAME="$3"
                    MISC="''${@:4}"
            
                    BASEDIR="$(dirname $0)"
            
                    HOOKPATH="$BASEDIR/qemu.d/$GUEST_NAME/$HOOK_NAME/$STATE_NAME"
            
                    set -e # If a script exits with an error, we should as well.
            
                    # check if it's a non-empty executable file
                    if [ -f "$HOOKPATH" ] && [ -s "$HOOKPATH"] && [ -x "$HOOKPATH" ]; then
                        eval \"$HOOKPATH\" "$@"
                    elif [ -d "$HOOKPATH" ]; then
                        while read file; do
                            # check for null string
                            if [ ! -z "$file" ]; then
                            eval \"$file\" "$@"
                            fi
                        done <<< "$(find -L "$HOOKPATH" -maxdepth 1 -type f -executable -print;)"
                    fi
                '';
                mode = "0755";
            };
        
            "libvirt/hooks/kvm.conf" = {
                text = ''
                    VIRSH_GPU_VIDEO=pci_0000_06_00_0
                    VIRSH_GPU_AUDIO=pci_0000_06_00_1
                '';
                mode = "0755";
            };
        
            "libvirt/hooks/qemu.d/win10/prepare/begin/start.sh" = {
                text = ''
                    #!/run/current-system/sw/bin/bash

                    # Load variables we defined
                    source "/etc/libvirt/hooks/kvm.conf"

                    # Unbind VTconsoles
                    echo 0 > /sys/class/vtconsole/vtcon0/bind
                    echo 0 > /sys/class/vtconsole/vtcon1/bind
            
                    # Avoid race condition
                    # sleep 5
            
                    # Unbind EFI Framebuffer
                    # echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
            
                    # Detach GPU devices from host
                    virsh nodedev-detach $VIRSH_GPU_VIDEO
                    virsh nodedev-detach $VIRSH_GPU_AUDIO

                    sleep 5

                    # Unload NVIDIA kernel modules
                    modprobe -r amdgpu            

                    # Load vfio module
                    # modprobe vfio-pci
                '';
                mode = "0755";
            };
        
            "libvirt/hooks/qemu.d/win10/release/end/stop.sh" = {
                text = ''
                    #!/run/current-system/sw/bin/bash

                    # Load variables we defined
                    source "/etc/libvirt/hooks/kvm.conf"
            
                    # Unload vfio module
                    # modprobe -r vfio-pci
            
                    # Attach GPU devices from host
                    virsh nodedev-reattach $VIRSH_GPU_VIDEO
                    virsh nodedev-reattach $VIRSH_GPU_AUDIO
            
                    # Bind EFI Framebuffer
                    # echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

                    # Load AMD kernel modules
                    modprobe amdgpu
            
                    # Avoid race condition
                    # sleep 5
            
                    # Bind VTconsoles
                    echo 1 > /sys/class/vtconsole/vtcon0/bind
                    echo 1 > /sys/class/vtconsole/vtcon1/bind
                '';
                mode = "0755";
            };       
        };
    };
}
