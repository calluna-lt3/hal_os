{ config, pkgs, lib, ... }:

{
    imports = [
        ./common.nix
    ];
    options.qemu.enable = lib.mkEnableOption "queue emo";
    config = lib.mkIf config.qemu.enable {
        programs.virt-manager.enable = true;
    };
}
