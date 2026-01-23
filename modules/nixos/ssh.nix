{ config, lib, pkgs, ... }:

{
    options.ssh.enable = lib.mkEnableOption "opawnssh";
    config = lib.mkIf config.ssh.enable {
        services.openssh = {
            enable = true;
            settings.PasswordAuthentication = false;
            settings.KbdInteractiveAuthentication = false;
            # knownHosts."eimi".hostNames = [
            #     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjzfMoC4FP7zg5sVO9WbeduubA48fYNJK6cgjESWrr8 eimi"
            # ];
        };

        users.users."mlwpsh".openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjzfMoC4FP7zg5sVO9WbeduubA48fYNJK6cgjESWrr8 eimi"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl8EONsjmfAp3z4fVAdrH0ruRZhnhCH8hP5HzFoHlEf verdant"
        ];
    };
}
