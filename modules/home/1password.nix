{ config, pkgs, lib, ... }:

{
    options.mallows.home."1password".enable = lib.mkEnableOption "1pawsword";
    config = lib.mkIf config.mallows.home."1password".enable {
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "1password-cli"
        ];

        home-manager.users."mlwpsh".home.packages = with pkgs; [ _1password-cli ];
    };
}
