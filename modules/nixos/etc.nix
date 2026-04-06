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
            "virtualbox-extpack"
            "terraform"
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
            man-pages

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
            fzf
            imv
            ffmpeg
            mpv

            ccache
            temurin-bin-17
            terraform
        ];

        fonts.packages = with pkgs; [
            ibm-plex
        ];
    };
}
