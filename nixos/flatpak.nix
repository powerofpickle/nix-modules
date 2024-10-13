{ config, pkgs, my-packages, ... }: {
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];

  environment.systemPackages = [
    my-packages.install-flatpaks
  ];
}
