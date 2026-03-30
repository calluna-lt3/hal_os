{ config, pkgs, lib, ... }:

{
    options.home.bash.enable = lib.mkEnableOption "bash v_v";
    config = lib.mkIf config.home.bash.enable {
        home-manager.users."mlwpsh".programs.bash = {
            enable = true;
            enableCompletion = true;
            sessionVariables = {
                MANPAGER = "nvim -c 'set signcolumn=no' +Man!";
                PATH = "$PATH:$HOME/.scripts/:$HOME/.local/bin";
                LD_LIBRARY_PATH = "LD_LIBRARY_PATH:/usr/local/lib";
                BROWSER = "librewolf";
                EDITOR = "nvim";
                HISTFILESIZE = "";
                HISTSIZE = "";
                GRIM_DEFAULT_DIR = "/tmp";

                # obs pipewire compatibility
                XDG_CURRENT_DESKTOP = "sway";

                GIT_PS1_SHOWDIRTYSTATE = 1;
                NIX_SHELL_PRESERVE_PROMPT = 1;
            };

            initExtra = ''
                . $HOME/.local/bin/git-prompt.sh
                . $HOME/.scripts/nixshellquestionmark
                export PS1=' [\h] $(__git_ps1 "(%s) ")\W/ $(__nixshell_ps1 "%s ")\[\e[1;\]\[$([[ $? = 0 ]] && printf 35 || printf 31)m\]<3\[\e[0m\] '
                '';

            shellAliases = {
                "ls" = "ls -F --color=auto";
                "ll" = "ls -FAlh --color=auto";
                "grep" = "grep --color=auto";
                ".." = "cd ./..";
                "..." = "cd ./../..";
                "...." = "cd ./../../..";
                "vp" = "zathura ";
                "vi" = "nvim";
                "vim" = "nvim";
                "pet" = "touch";
                "sf" = "cd '$(dirname $(find $HOME/storage $HOME/ -type f | fzf ))'";
                "sd" = "cd '$(find $HOME/storage/ $HOME/ -type d | fzf)'";
                "tfd" = "cd $HOME/.local/share/Steam/steamapps/common/Team\\ Fortress\\ 2/tf";
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
