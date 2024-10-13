{ config, pkgs, ... }:
{

  programs.command-not-found.enable = false;

  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

}
