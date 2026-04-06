{ config, pkgs, lib, ... }:

{
    # included vased on qemu.enable ?
    modules = [
        ./common.nix
    ];
    options.qemu.enable = lib.mkEnableOption "queue emo";
    config = lib.mkIf config.qemu.enable {
        programs.virt-manager.enable = true;
    };
}
