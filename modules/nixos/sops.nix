{ config, lib, pkgs, ... }:

{
    options.mallows.sops.enable = lib.mkEnableOption "shout out puppies, #swag";
    config = lib.mkIf config.mallows.sops.enable {
        environment.systemPackages = with pkgs; [ sops ];

        sops.defaultSopsFile = ../../secrets/secrets.yaml;
        sops.defaultSopsFormat = "yaml";

        sops.age.keyFile = "/home/mlwpsh/.config/sops/age/keys.txt";
    };
}
