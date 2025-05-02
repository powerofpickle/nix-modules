{ config, pkgs, ... }:
{

  fonts.packages = with pkgs; [
    font-awesome # For waybar
  ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      sway
      swaylock
      swayidle
      fuzzel
      wayland
      waybar
      adwaita-icon-theme
      playerctl # For MPRIS play-pause/next/previous
      alacritty
      jq # For focused-cwd script
      swaynotificationcenter
      wtype # For bemoji emoji typing
      grim # Select a region in a Wayland compositor
      slurp # Grab images from a Wayland compositor
      brightnessctl
      pavucontrol # For volume gui
      pulseaudio # For pactl volume control
      autotiling # Auto-tile windows based on aspect ratio
      wl-clipboard # Allows neovim to copy to clipboard
      gammastep
      dmenu # For dmenu_path command to pipe to fuzzel --dmenu
      bemoji # Emoji picker
      workstyle # Workspace icons based on applications
      sway-overfocus # Separate shortcuts for navigating splits vs tabs/stacks
      banana-cursor
    ];
  };
}
