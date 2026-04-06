{ config, pkgs, lib, ... }:

{
    users.groups.libvirtd.members = [ "mlwpsh" ];
    users.groups.kvm.members = [ "mlwpsh" ];
    virtualisation = {
        libvirtd = {
            enable = true;
            qemu = {
                # win 11 tpm emulation
                swtpm.enable = true;
            };
        };

        spiceUSBRedirection.enable = true;
    };
}
