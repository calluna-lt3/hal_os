{ config, lib, pkgs, ... }:

{
    options.mallows.python.enable = lib.mkEnableOption "snake!";
    config = lib.mkIf config.mallows.python.enable {
        environment.systemPackages = with pkgs; [
            python3
            python313Packages.python-lsp-server
        ];
    };
}
