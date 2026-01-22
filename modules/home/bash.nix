{ config, pkgs, lib, ... }:

{
    options.home.bash.enable = lib.mkEnableOption "bash v_v";
    config = lib.mkIf config.home.bash.enable {
        home-manager.users."mlwpsh".programs.bash = {
            enable = true;
            sessionVariables = {
                MANPAGER = "$HOME/.local/bin/nvim -c 'set signcolumn=no' +Man!";
                PATH = "$PATH:$HOME/.scripts/:$HOME/storage/bin";
                LD_LIBRARY_PATH = "LD_LIBRARY_PATH:/usr/local/lib";
                BROWSER = "librewolf";
                EDITOR = "$HOME/.local/bin/nvim";
                VIMRUNTIME = "$HOME/.local/share/nvim/runtime";
                HISTFILESIZE = "";
                HISTSIZE = "";

                # obs pipewire compatibility
                XDG_CURRENT_DESKTOP = "sway";
            };

            initExtra = "
                source $HOME/.local/bin/git-prompt.sh
                export PS1=\" [\\h] $(__git_ps1 \'(%s) \')\\W/ \\[\\e[1;\\]\\[$([[ $? = 0 ]] && printf 35 || printf 31)m\\]<3\\[\\e[0m\\] \"
                ";

            shellAliases = {
                "ls" = "ls -F --color=auto";
                "ll" = "ls -FAlh --color=auto";
                "grep" = "grep --color=auto";
                ".." = "cd ./..";
                "..." = "cd ./../..";
                "...." = "cd ./../../..";
                "vp" = "zathura ";
                "vi" = "$HOME/.local/bin/nvim";
                "vim" = "$HOME/.local/bin/nvim";
                "nvim" = "$HOME/.local/bin/nvim";
                "pet" = "touch";
                "sf" = "cd '$(dirname $(find $HOME/storage $HOME/ -type f | fzf ))'";
                "sd" = "cd '$(find $HOME/storage/ $HOME/ -type d | fzf)'";
                "tfd" = "cd '$HOME/.local/share/Steam/steamapps/common/Team Fortress 2/tf'";
                "config" = "/usr/bin/env git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
                "tfcfg" = "/usr/bin/env git --git-dir=$HOME/.local/share/Steam/steamapps/common/Team\\ Fortress\\ 2/.cfg  --work-tree=$HOME/.local/share/Steam/steamapps/common/Team\\ Fortress\\ 2/";

                # [S|Plebeian IV] Golden halo: kjr = cringe
                # [S|Plebeian IV] Golden halo: boom
                # [O|Sir IV] kjr.: wow
                # kjr. has left the server.
                # [S|Plebeian IV] Golden halo: rq
                "rq" = "shutdown now";
            };
        };
    };
}
