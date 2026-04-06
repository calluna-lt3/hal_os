{ config, lib, pkgs, ... }:

{
    options.mallows.lua.enable = lib.mkEnableOption "lua";
    config = lib.mkIf config.mallows.lua.enable {
        environment.systemPackages = with pkgs; [
            lua
            lua-language-server
            stylua
        ];
    };
}
