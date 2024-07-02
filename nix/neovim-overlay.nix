{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    gruvbox-nvim
    tokyonight-nvim
    everforest

    neodev-nvim

    oil-nvim
    undotree

    nvim-treesitter.withAllGrammars
    luasnip

    # Autocompletion
    nvim-cmp
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

    # UI
    nvim-treesitter-context # nvim-treesitter-context

    # Navigation
    nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/

    # libraries that other plugins depend on
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
  ];

  extraPackages = with pkgs; [
    # LSP
    cargo
    rust-analyzer
    rustfmt

    lua-language-server
    nil
  ];
in {
  nvim-pkg = mkNeovim {
    plugins = plugins;
    inherit extraPackages;
  };
}
