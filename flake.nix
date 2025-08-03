{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      packages = (
        forAllSystems (
          system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            scripts = {
              install-flatpaks = ./scripts/install_flatpaks.sh;
            };
          in
          (builtins.mapAttrs (name: path: pkgs.writeScriptBin name (builtins.readFile path)) scripts)
          // import ./packages/calc.nix pkgs
        )
      );
      nixosModules =
        let
          modulesDir = ./nixos;

          fileNames = builtins.attrNames (builtins.readDir modulesDir);

          lib = nixpkgs.lib;
          wrapModule =
            module:
            (
              if builtins.isFunction module then
                args@{ pkgs, ... }: module (args // { my-packages = packages.${pkgs.system}; })
              else
                module
            );

          moduleName = fileName: lib.removeSuffix ".nix" fileName;

          fileNameToNameAndVal = fileName: {
            name = moduleName fileName;
            value = wrapModule (import "${modulesDir}/${fileName}");
          };
        in
        builtins.listToAttrs (map fileNameToNameAndVal fileNames);
      lib = {
        mkNixosConfigurations =
          extraModules: extraNixpkgs: entrypoints:
          let
            mkConfig =
              entrypointPath:
              nixpkgs.lib.nixosSystem {
                specialArgs = {
                  my-modules = nixosModules;
                  my-lib = lib;
                };
                modules = [
                  entrypointPath
                  (
                    { pkgs, ... }:
                    {
                      _module.args =
                        let
                          system = pkgs.system;
                        in
                        {
                          my-packages = packages.${system};
                        }
                        // (builtins.mapAttrs (_: input: (import input { system = system; })) extraNixpkgs);

                      /*
                        nix.nixPath = [
                          "nixpkgs=${nixpkgs.outPath}"
                          "nixos=${nixpkgs.outPath}"
                        ];
                      */
                    }
                  )
                ] ++ extraModules;
              };
          in
          builtins.mapAttrs (_: path: (mkConfig path)) entrypoints;

        neovim = import ./lib/neovim.nix;
        forAllSystems = forAllSystems;
      } // (import ./lib/misc.nix);
    in
    {
      nixosModules = nixosModules;
      packages = packages;
      lib = lib;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
