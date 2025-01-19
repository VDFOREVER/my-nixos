{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.nvim;
in
{
    options.nvim = {
        enable = mkEnableOption "Enable neovim, console based text editor";
    };

    config = mkIf cfg.enable {
        programs.neovim = {
            enable = true;
            viAlias = true;
            defaultEditor = true;
            vimAlias = true;
            vimdiffAlias = true;
            coc.enable = true;
            plugins = with pkgs.vimPlugins; [
                nerdtree
                coc-nvim
                coc-clangd
                coc-sh
                coc-cmake
                nvim-cmp
                toggleterm-nvim
            ];
            extraLuaConfig = ''
                vim.cmd([[
                    highlight Normal guifg=#bbddff
                    set number
                    set tabstop=4
                    set softtabstop=4
                    set shiftwidth=4
                    set expandtab
                    set autoindent
                    set smartindent
                    packadd termdebug
                    set clipboard+=unnamedplus

                    nnoremap <C-t> :NERDTreeToggle<CR>
                ]])
            '';
        };
    };
}