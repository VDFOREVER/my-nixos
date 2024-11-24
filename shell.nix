{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [ gcc cmake];
  buildInputs =  with pkgs; [ openssl zlib boost opencv];

  shellHook = ''
    echo "Welcome to the C++ build environment!"
  '';
}
