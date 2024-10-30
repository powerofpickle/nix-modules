{
  isHomeManager ? false,
  pkgs-unstable ? null,
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  neovimNixpkgs = if isNull pkgs-unstable then pkgs else pkgs-unstable;
  enableAvante = !isNull pkgs-unstable;
  avantePackages =
    if enableAvante then
      [
        pkgs.gnumake
        /*
          pkgs.cargo
          pkgs-unstable.rustc
          pkgs.openssl
          pkgs.pkg-config
        */
      ]
    else
      [ ];
  neovimPackages =
    with pkgs;
    [
      neovimNixpkgs.neovim
      clang-tools
      ranger
      python3Packages.python-lsp-server
      lua-language-server
      ripgrep
      gcc
    ]
    ++ avantePackages;
  settings =
    if isHomeManager then
      {
        home.packages = neovimPackages;
        home.sessionVariables = {
          EDITOR = "nvim";
        };
      }
    else
      { environment.systemPackages = neovimPackages; };
in
settings
