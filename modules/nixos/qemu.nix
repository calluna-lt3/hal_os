{ config, pkgs, lib, ... }:

{
    options.qemu.enable = lib.mkEnableOption "queue emo";
    config = lib.mkIf config.qemu.enable {
        users.groups.libvirtd.members = [ "mlwpsh" ];
        users.groups.kvm.members = [ "mlwpsh" ];
        programs.virt-manager.enable = true;
        virtualisation.spiceUSBRedirection.enable = true;
    };
}
