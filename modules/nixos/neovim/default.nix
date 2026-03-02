{ config, lib, pkgs, ... }:

{
    programs.nixvim = {
        enableMan = true;
        enable = true;
        globals.mapleader = " ";

        opts =  {
            guicursor = "";
            mouse = "";
            winborder = "single";

            number = true;
            relativenumber = true;
            splitright = true;

            tabstop = 4;
            softtabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            wrap = false;

            swapfile = false;
            backup = false;
            undodir = "${config.users.users.mlwpsh.home}/.vim/undodir";
            undofile = true;

            hlsearch = false;
            incsearch = true;

            scrolloff = 8;
            signcolumn = "yes";
            updatetime = 50;
            colorcolumn = "80";

            list = true;
            listchars.__raw = "{ tab = '> ', trail = '$' }";
        };

        colorscheme = "ashen";

        keymaps = [
            {
                mode = [ "n" "v" "x" ];
                key = "<leader>sy";
                action = "\"+y";
            }
            {
                mode = [ "n" "v" "x" ];
                key = "<leader>sp";
                action = "\"+p";
            }
            {
                mode = "n";
                key = "<C-u>";
                action = "<C-u>zz";
            }
            {
                mode = "n";
                key = "<C-d>";
                action = "<C-d>zz";
            }
            {
                mode = "n";
                key = "n";
                action = "nzz";
            }
            {
                mode = "n";
                key = "N";
                action = "Nzz";
            }
            {
                mode = "n";
                key = "<C-i>";
                action = "<C-i>zz";
            }
            {
                mode = "n";
                key = "<C-o>";
                action = "<C-o>zz";
            }
            {
                mode = [ "n" "v" ];
                key = "gk";
                action = "ggzz";
            }
            {
                mode = [ "n" "v" ];
                key = "gj";
                action = "Gzz";
            }
            {
                mode = "v";
                key = "<C-j>";
                action = ":m '>+1<CR> gv=gv";
            }
            {
                mode = "v";
                key = "<C-k>";
                action = ":m '<-2<CR> gv=gv";
            }
            {
                mode = "n";
                key = "<leader>k";
                action = "<CMD>vert Man<CR><CMD>set signcolumn=no<CR>";
            }
            {
                mode = "n";
                key = "<leader>o";
                action = "<CMD>set nohls<CR>";
            }
            {
                mode = "n";
                key = "/";
                action = "<CMD>set hls<CR>/";
            }
            {
                mode = "n";
                key = "#";
                action = "<CMD>set hls<CR>#";
            }
            {
                mode = "n";
                key = "*";
                action = "<CMD>set hls<CR>*";
            }
            {
                mode = "n";
                key = "<leader>v";
                action = "<CMD>Ex<CR>";
            }

            # plugin keybind below ! ! !
            {
                mode = "n";
                key = "<leader>u";
                action = "<CMD>UndotreeToggle<CR>";
            }
            {
                mode = "n";
                key = "<leader>g";
                action = "<CMD>Git<CR>";
            }
            {
                mode = "n";
                key = "<leader>lf";
                action.__raw = ''
                    function()
                        require("conform").format { async = true, lsp_fallback = true }
                    end
                    '';
            }
            {
                mode = "n";
                key = "<C-e>";
                action.__raw = ''
                    require("grapple").toggle_tags
                    '';
            }
            {
                mode = "n";
                key = "<C-q>";
                action.__raw = ''
                    function()
                        require("grapple").toggle_tags({ scope = "global" })
                    end
                    '';
            }

            {
                mode = "n";
                key = "<leader>e";
                action.__raw = ''
                    require("grapple").tag
                    '';
            }
            {
                mode = "n";
                key = "<leader>q";
                action.__raw = ''
                    function()
                        require("grapple").tag({ scope = "global" })
                    end
                    '';
            }
            {
                mode = "n";
                key = "<C-j>";
                action.__raw = ''
                    function()
                        require("grapple").select({ index = 1 })
                    end
                    '';
            }
            {
                mode = "n";
                key = "<C-k>";
                action.__raw = ''
                    function()
                        require("grapple").select({ index = 2 })
                    end
                    '';
            }
            {
                mode = "n";
                key = "<C-l>";
                action.__raw = ''
                    function()
                        require("grapple").select({ index = 3 })
                    end
                    '';
            }
            {
                mode = "n";
                key = "<C-h>";
                action.__raw = ''
                    function()
                        require("grapple").select({ index = 4 })
                    end
                    '';
            }
        ];

        plugins = {
            # SHUT UPPP
            web-devicons.enable = false;
            undotree.enable = true;
            fugitive.enable = true;
            vimtex = {
                enable = true;
                texlivePackage = pkgs.texlive.combined.scheme-full;
                zathuraPackage = null;
                settings = {
                    view_method = "zathura";
                    compiler_method = "latexmk";
                    quickfix_mode = 2;
                    conceal = "abdmg";
                };
            };
            conform-nvim = {
                enable = true;
                settings = {
                    formatters_by_ft = {
                        python = [ "black" ];
                        lua = [ "stylua" ];
                        rust = [ "rustfmt" ];
                        c = [ "clang_format" ];
                    };
                    formatters = {
                        stylua.prepend_args = [
                            "--indent-type"
                            "Spaces"
                            "--quote-style"
                            "ForceSingle"
                        ];
                    };
                };
            };
            lsp = {
                enable = true;
                servers = {
                    clangd.enable = true;
                    rust_analyzer = {
                        enable = true;
                        installCargo = false;
                        installRustc = false;
                    };
                    lua_ls.enable = true;
                    nil_ls.enable = true;
                    pyright.enable = true;
                };

                onAttach = ''
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
                    vim.keymap.set('n', 'E', '<CMD>lua vim.diagnostic.open_float()<CR>', opts)
                    vim.keymap.set('n', '<leader>n', '<CMD>lua vim.lsp.buf.rename()<CR>')
                    '';

            };
            blink-cmp = {
                enable = true;
                settings = {
                    keymap = {
                        "<C-j>" = [
                            "show"
                            "select_next"
                        ];
                        "<C-k>" = [
                            "select_prev"
                            "fallback"
                        ];
                        "<C-l>" = [
                            "select_and_accept"
                            "fallback"
                        ];
                    };
                };
            };
            telescope = {
                enable = true;
                keymaps = {
                    "<leader>f" = {
                        mode = "n";
                        action = "find_files";
                    };
                    "<leader>lg" = {
                        mode = "n";
                        action = "live_grep";
                    };
                    "<leader>ls" = {
                        mode = "n";
                        action = "grep_string";
                    };
                    "<leader>r" = {
                        mode = "n";
                        action = "lsp_references";
                    };
                    "<leader>d" = {
                        mode = "n";
                        action = "lsp_definitions";
                    };
                    "<leader>i" = {
                        mode = "n";
                        action = "lsp_implementations";
                    };
                    "<leader>t" = {
                        mode = "n";
                        action = "lsp_type_definitions";
                    };
                };
            };
        };

        extraPlugins = with pkgs; [
            vimPlugins.grapple-nvim
            (vimUtils.buildVimPlugin {
                name = "ashen.nvim";
                src = fetchFromGitHub {
                    owner = "ficd0";
                    repo = "ashen.nvim";
                    rev = "bfb04bd50b69d863469b2deb9fb361cf0d945ba7";
                    hash = "sha256-yC9V58zieE8YvEuAnJhEOgONrudUJgQFqC59cKo97/g=";
                };
            })

            # fails require checks, look into this later
            # (vimUtils.buildVimPlugin {
            #     name = "compile-mode.nvim";
            #     src = fetchFromGitHub {
            #         owner = "ej-shafran";
            #         repo = "compile-mode.nvim";
            #         rev = "6b41499bd782be2c213011072ce0f0eb9f7b78a2";
            #         hash = "sha256-AoEuE+BLQwAHgvkanLUU6kd4HhAyn9Y53lRAYnoghz4=";
            #     };
            # })
        ];

        extraConfigLua = ''
            require("grapple").setup({
                icons = false,
            })
            '';
    };
}
