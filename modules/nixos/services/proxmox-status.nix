{ config, lib, pkgs, ... }:

{
    options.mallows.services.proxmox-status.enable = lib.mkEnableOption "manages proxmox.sh for sway bar";
    config = lib.mkIf config.mallows.services.proxmox-status.enable {
        systemd.services.proxmox-status = {
            enable = true;
            description = "Checks whether proxmox server is up/down, echos status to file for sway-bar to read";
            wantedBy = [ "multi-user.target" ];
            path = [ pkgs.netcat-gnu ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.bash}/bin/bash /home/mlwpsh/.scripts/sway-bar/proxmox-status.sh";
                Restart = "on-failure";
                RestartSec = 2;
            };
        };
    };
}
