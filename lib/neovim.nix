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
  enableAvante = if isNull pkgs-unstable then false else true;
  avantePackages = if enableAvante then [
    pkgs.gnumake
    /*
    pkgs.cargo
    pkgs-unstable.rustc
    pkgs.openssl
    pkgs.pkg-config
    */
  ] else [];
  neovimPackages = with pkgs; [
    neovimNixpkgs.neovim
    clang-tools
    ranger
    python3Packages.python-lsp-server
    lua-language-server
    ripgrep
    gcc
  ] ++ avantePackages;
  packagesSetting =
    if isHomeManager then
      { home.packages = neovimPackages; }
    else
      { environment.systemPackages = neovimPackages; };
in
packagesSetting
