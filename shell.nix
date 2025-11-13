{
  pkgs ? import <nixpkgs> {}
}:
pkgs.mkShellNoCC {
  packages = [
    pkgs.stow
  ] ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.isDarwin) [
    pkgs.dockutil
  ];
}
