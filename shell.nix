# Pinned to lock in a last known good build.
{
  pkgs ? import (builtins.fetchTarball {
    # Source: https://github.com/NixOS/nixpkgs/issues/483584
    name = "nixos-pre-swift-break";
    url = "https://github.com/nixos/nixpkgs/archive/70801e06d9730c4f1704fbd3bbf5b8e11c03a2a7.tar.gz";
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "075kc4zlwrdpdvcw75kgv7zxpsv0ss0clcsfhqvdxpzal3l1cbkh";
  }) {}
}:
pkgs.mkShellNoCC {
  packages = [
    pkgs.stow
    pkgs.just
  ] ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.isDarwin) [
    pkgs.dockutil
  ];
}
