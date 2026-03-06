{ pkgs ? import <nixpkgs> { }
}:
pkgs.mkShellNoCC {
  packages = [
    pkgs.stow
    pkgs.just
  ] ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.isDarwin) [
    pkgs.dockutil
  ];
}
