{ pkgs, lib, stdenv, pkgs-wrapNeovim ? pkgs }:
with lib;
  {
    neovim-unwrapped ? pkgs-wrapNeovim.neovim-unwrapped,
    plugins ? [],
    devPlugins ? [],
    ignoreConfigRegexes ? [],
    extraPackages ? [],
    extraLuaPackages ? p: [],
    extraPython3Packages ? p: [],
    withPython3 ? true,
    withRuby ? false,
    withNodeJs ? false,
    viAlias ? true,
    vimAlias ? true,
  }: let
    defaultPlugin = {
      plugin = null;
      config = null;
      optional = false;
      runtime = {};
    };
    normalizedPlugins = map (x:
      defaultPlugin
      // (
        if x ? plugin
        then x
        else {plugin = x;}
      ))
    plugins;

    neovimConfig = pkgs-wrapNeovim.neovimUtils.makeNeovimConfig {
      inherit extraPython3Packages withPython3 withRuby withNodeJs viAlias vimAlias;
      plugins = normalizedPlugins;
    };

    nvimRtpSrc = let
      src = ../nvim;
    in
      lib.cleanSourceWith {
        inherit src;
        name = "nvim-rtp-src";
        filter = path: tyoe: let
          srcPrefix = toString src + "/";
          relPath = lib.removePrefix srcPrefix (toString path);
        in
          lib.all (regex: builtins.match regex relPath == null) ignoreConfigRegexes;
      };

    nvimRtp = stdenv.mkDerivation {
      name = "nvim-rtp";
      src = nvimRtpSrc;

      buildPhase = ''
        mkdir -p $out/nvim
        mkdir -p $out/lua
        rm init.lua
      '';

      installPhase = ''
        cp -r lua $out/lua
        rm -r lua
        cp -r * $out/nvim
      '';
    };

    initLua =
      ''
        vim.loader.enable()
        -- prepend lua directory
        vim.opt.rtp:prepend('${nvimRtp}/lua')
      ''
      + (builtins.readFile ../nvim/init.lua)
      + optionalString (devPlugins != []) (
        ''
          local dev_pack_path = vim.fn.stdpath('data') .. '/site/pack/dev'
          local dev_plugins_dir = dev_pack_path .. '/opt'
          local dev_plugin_path
        ''
        + strings.concatMapStringsSep
        "\n"
        (plugin: ''
          dev_plugin_path = dev_plugins_dir .. '/${plugin.name}'
          if vim.fn.empty(vim.fn.glob(dev_plugin_path)) > 0 then
            vim.notify('Bootstrapping dev plugin ${plugin.name} ...', vim.log.levels.INFO)
            vim.cmd('!${pkgs.git}/bin/git clone ${plugin.url} ' .. dev_plugin_path)
          end
          vim.cmd('packadd! ${plugin.name}')
        '')
        devPlugins
      )
      + ''
        vim.opt.rtp:prepend('${nvimRtp}/nvim')
      '';

    extraMakeWrapperArgs = builtins.concatStringsSep " " (
      (optional (extraPackages != [])
        ''--prefix PATH : "${makeBinPath extraPackages}"'')
    );

    luaPackages = neovim-unwrapped.lua.pkgs;
    resolvedExtraLuaPackages = extraLuaPackages luaPackages;

    extraMakeWrapperLuaCArgs =
      optionalString (resolvedExtraLuaPackages != [])
      ''--suffix LUA_CPATH ";" "${concatMapStringsSep ";" luaPackages.getLuaCPath resolvedExtraLuaPackages}"'';

    extraMakeWrapperLuaArgs =
      optionalString (resolvedExtraLuaPackages != [])
      ''--suffix LUA_PATH ";" "${concatMapStringsSep ";" luaPackages.getLuaPath resolvedExtraLuaPackages}"'';

    neovim-wrapped = pkgs-wrapNeovim.wrapNeovimUnstable neovim-unwrapped (neovimConfig
      // {
        luaRcContent = initLua;
        wrapperArgs =
          escapeShellArgs neovimConfig.wrapperArgs
          + " "
          + extraMakeWrapperArgs
          + " "
          + extraMakeWrapperLuaCArgs
          + " "
          + extraMakeWrapperLuaArgs;
        wrapRc = true;
      });
  in
    neovim-wrapped
