{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  plugins = with pkgs.vimPlugins; [
    # Themes
    gruvbox-nvim

    # LSP
    nvim-lspconfig
    neodev-nvim

    oil-nvim
    undotree

    nvim-treesitter.withAllGrammars

    # Autocompletion
    nvim-cmp
    luasnip
    cmp-nvim-lsp
    cmp_luasnip
    cmp-buffer
    cmp-path
    cmp-nvim-lua
    cmp-cmdline

    # Git
    gitsigns-nvim
    vim-fugitive

    # Telescope
    telescope-nvim
    telescope-fzy-native-nvim

    # libraries that other plugins depend on
    plenary-nvim
    nvim-web-devicons
  ];

  extraPackages = with pkgs; [
    lua-language-server
    nil
  ];
in {
  nvim-pkg = mkNeovim { inherit plugins extraPackages; };
}
