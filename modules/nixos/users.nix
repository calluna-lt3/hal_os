{ config, lib, pkgs, ... }:

{
    sops.secrets."users/mlwpsh/hashed".neededForUsers = true;

    users.mutableUsers = false;
    users.users = {
        root = {
            hashedPassword = "*";
        };
        "mlwpsh" = {
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets."users/mlwpsh/hashed".path;
            home = "/home/mlwpsh";
            extraGroups = [ "wheel" ];
        };
    };
}
