{ pkgs ? import <nixpkgs> { }
}:
pkgs.mkShellNoCC {
  packages = [
    pkgs.stow
    pkgs.just
  ];
}
