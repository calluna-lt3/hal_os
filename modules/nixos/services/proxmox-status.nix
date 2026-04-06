{ config, lib, pkgs, ... }:

{
    options.mallows.services.proxmox-status.enable = lib.mkEnableOption "manages proxmox.sh for sway bar";
    config = lib.mkIf config.mallows.services.proxmox-status.enable {
        systemd.services.proxmox-status = {
            enable = true;
            description = "Checks whether proxmox server is up/down, echos status to file for sway-bar to read";
            wantedBy = [ "multiuser.target" ];
            serviceConfig = {
                Type = "simple";
                # assume we have `sh` in PATH because i dont wnna deal with home manger right now
                ExecStart = "sh /home/mlwpsh/.config/sway/bar/proxmox-status.sh";
                Restart = "on-failure";
                RestartSec = 2;
            };
        };
    };
}
