{ config, lib, pkgs, ... }:

{
    sops.secrets."users/mlwpsh/hashed".neededForUsers = true;

    users.mutableUsers = false;
    users.users = {
        root = {
            hashedPassword = "$y$j9T$xMOfxBXWwSXKO.Mw6XFky0$uiPwFFK5x9S0JSQ9mT7neYHM7lSI1M4E86bWzgnBFsB";
        };
        "mlwpsh" = {
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets."users/mlwpsh/hashed".path;
            home = "/home/mlwpsh";
            extraGroups = [ "wheel" ];
        };
    };
}
