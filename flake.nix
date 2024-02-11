{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: rec {
    nixosModules = {
        sway = import ./nixos/sway.nix;
        flatpak = import ./nixos/flatpak.nix;
        swap-alt-and-meta = import ./nixos/swap-alt-and-meta.nix;
        nix-index = import ./nixos/nix-index.nix;
    };
  };
}
