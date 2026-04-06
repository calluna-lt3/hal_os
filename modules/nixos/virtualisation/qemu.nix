{ config, pkgs, lib, ... }:

{
    options.virtualisation.qemu.enable = lib.mkEnableOption "queue emo";
    config = lib.mkIf config.virtualisation.qemu.enable {
        programs.virt-manager.enable = true;
    };
}
