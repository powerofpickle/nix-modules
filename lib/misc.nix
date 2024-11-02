{
  # If shell is interactive exec alternative shell
  mkShellSwitcher = shellName: ''
    case $- in
      *i*) SHELL=$(which ${shellName}); export SHELL; exec "$SHELL";
    esac
  '';
}
