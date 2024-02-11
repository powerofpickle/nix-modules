{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: rec {
    nixosModules = {
        swap-alt-and-meta = ./nixos/swap-alt-and-meta.nix;
    };
  };
}
