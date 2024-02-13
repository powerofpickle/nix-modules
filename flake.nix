{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: rec {
    nixosModules = {
        sway = import ./nixos/sway.nix;
        flatpak = import ./nixos/flatpak.nix;
        remap-keys = import ./nixos/remap-keys.nix;
        nix-index = import ./nixos/nix-index.nix;
    };
  };
}
