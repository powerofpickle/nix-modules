{
  services.keyd = {
    enable = true;
    keyboards.swap_alt_and_meta.settings = {
      main = {
        # Swap Alt and Super keys
        leftalt = "leftmeta";
        leftmeta = "leftalt";
      };
    };
  };
}
