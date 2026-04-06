{ config, pkgs, lib, ... }:

{
    options.mallows.virtualisation.qemu.enable = lib.mkEnableOption "queue emo";
    config = lib.mkIf config.mallows.virtualisation.qemu.enable {
        programs.virt-manager.enable = true;
    };
}
