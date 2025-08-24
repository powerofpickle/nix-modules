let
  pythonVersion = "";
  getPythonPackages =
    ps: with ps; [
      ipython

      matplotlib
      numpy
      pandas
      scipy
      sympy
    ];
in
pkgs: {
  calc = pkgs.writeShellScriptBin "calc" ''
    exec ${
      pkgs."python3${pythonVersion}".withPackages getPythonPackages
    }/bin/ipython --no-banner -i ${./calc_imports.py} "$@"
  '';
}
