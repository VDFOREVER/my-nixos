{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs =  with pkgs; [ gcc cmake openssl zlib boost opencv];

  shellHook = ''
    echo "Welcome to the C++ build environment!"
  '';
}
