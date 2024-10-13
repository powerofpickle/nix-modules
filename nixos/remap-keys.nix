{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        # Swap Alt and Super keys
        leftalt = "leftmeta";
        leftmeta = "leftalt";
        rightalt = "rightmeta";
        rightcontrol = "rightalt"; # AltGr, for international keyboard

        # Maps capslock to escape when pressed and control when held
        capslock = "overload(control, esc)";
        # Remaps the escape key to capslock
        esc = "capslock";
      };
    };
  };
}
