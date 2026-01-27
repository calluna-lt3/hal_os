{ config, lib, pkgs, ... }:

{
    options.lua.enable = lib.mkEnableOption "lua";
    config = lib.mkIf config.lua.enable {
        environment.systemPackages = with pkgs; [
            lua
            lua-language-server
        ];
    };
}
