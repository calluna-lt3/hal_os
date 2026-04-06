{ config, pkgs, lib, ... }:

{
    imports = [
        ./qemu.nix
        ./virtualbox.nix
    ];
    options.virtualisation.enable = lib.mkEnableOption "common virt settings";
    config = lib.mkIf config.virtualisation.enable {
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
    };
}
