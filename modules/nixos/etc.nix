{ config, lib, pkgs, ... }:

{
    options.etc.enable = lib.mkEnableOption "etc ####";
    config = lib.mkIf config.etc.enable {
        # TODO: figure out how to put this in modules
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "steam"
            "steam-unwrapped"
            "1password-cli"
            "discord"
        ];

        environment.systemPackages = with pkgs; [
            # programming
            ghc
            haskell-language-server
            gcc
            clang
            clang-tools
            cargo
            rustc
            rust-analyzer

            # graphics
            clinfo
            vulkan-tools

            # audio
            pavucontrol

            # system tools
            curl
            htop
            tmux
            unzip
            vim
            wget
            zip

            # extra
            fastfetch
            age
            gnupg
            texliveFull
            fzf
            imv
            ffmpeg
            mpv

            temurin-bin-17
        ];

        fonts.packages = with pkgs; [
            ibm-plex
        ];
    };
}
