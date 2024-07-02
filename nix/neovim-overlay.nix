{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  plugins = with pkgs.vimPlugins; [
    # Themes
    gruvbox-nvim
    tokyonight-nvim

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
    cmp-cmdline # cmp command line suggestions
    cmp-cmdline-history # cmp command line history suggestions

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
    # Rust
    cargo
    rust-analyzer
    rustfmt

    # Lua
    lua-language-server

    # Nix
    nil
    nixfmt-classic
  ];
in {
  nvim-pkg = mkNeovim { inherit plugins extraPackages; };
}
