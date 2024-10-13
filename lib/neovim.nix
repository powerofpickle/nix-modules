{
  isHomeManager ? false,
  neovimNixpkgs ? null,
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  neovimNixpkgs' = if isNull neovimNixpkgs then pkgs else neovimNixpkgs;
  neovimPackages = with pkgs; [
    neovimNixpkgs'.neovim
    clang-tools
    ranger
    python3Packages.python-lsp-server
    lua-language-server
    ripgrep
    gcc
  ];
  packagesSetting =
    if isHomeManager then
      { home.packages = neovimPackages; }
    else
      { environment.systemPackages = neovimPackages; };
in
packagesSetting
