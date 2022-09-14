{ pkgs ? import <nixpkgs> {} }:

let
  yotta = p: p.callPackage ./default.nix {
    pkgs = pkgs;
    pythonPackages = p;
  };
  python = pkgs.python38;
  pythonWPackages = python.withPackages(p: [
    (yotta p)
  ]);

in pkgs.mkShell {
  buildInputs = (with pkgs; [
    cmake
    ninja
    ncurses
    gcc-arm-embedded
    pythonWPackages
    srecord
  ]);
}
