{
  pkgs ? import <nixpkgs> {}
}:
pkgs.mkShellNoCC {
  packages = [
    pkgs.gnumake
    pkgs.stow
  ];
}
