{ config, lib, pkgs, ... }:

{
    options.python.enable = lib.mkEnableOption "snake!";
    config = lib.mkIf config.python.enable {
        environment.systemPackages = with pkgs; [
            python3
            python313Packages.python-lsp-server
        ];
    };
}
