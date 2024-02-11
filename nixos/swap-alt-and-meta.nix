{
  services.keyd = {
    enable = true;
    keyboards.swap_meta_and_alt.settings = {
      main = {
        # Swap Alt and Super keys
        leftalt = "leftmeta";
        leftmeta = "leftalt";
      };
    };
  };
}
