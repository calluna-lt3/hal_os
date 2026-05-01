{ config, lib, pkgs, ... }:

{
    options.mallows.services.mpd.enable = lib.mkEnableOption "mpddd";
    config = lib.mkIf config.mallows.services.mpd.enable {
        environment.systemPackages = with pkgs; [ rmpc ];
        services.mpd = {
            enable = true;
            user = "mlwpsh";
            dataDir = "/mnt/external/hdd0/media/audio/mpd";
            settings = {
                music_directory = "/mnt/external/hdd0/media/audio/music";
                audio_output = [
                    {
                        type = "pulse";
                        name = "pulse output";
                        server = "/run/user/1001/pulse/native";
                    }
                ];
            };
        };
    };
}
