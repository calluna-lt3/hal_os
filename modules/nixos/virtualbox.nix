{ config, pkgs, lib, ... }:

{
    options.vbox.enable = lib.mkEnableOption "gitgitgit";
    config = lib.mkIf config.vbox.enable {
        environment.systemPackages = with pkgs; [
            gnome-boxes
            dnsmasq
        ];

        users.groups.libvirtd.members = [ "mlwpsh" ];
        users.groups.kvm.members = [ "mlwpsh" ];
        users.groups.vboxusers.members = [ "mlwpsh" ];

        virtualisation = {
            virtualbox= {
                host = {
                    enable = true;
                    enableExtensionPack = true;
                };

                guest.enable = true;
            };
            libvirtd = {
                enable = true;

                # Enable TPM emulation (for Windows 11)
                qemu = {
                    swtpm.enable = true;
                };
            };

            spiceUSBRedirection.enable = true;
        };
    };
}
