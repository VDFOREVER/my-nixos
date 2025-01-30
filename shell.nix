{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    gdb
    openssl
    zlib
    boost
    cmake
    clang-tools
    ncurses
  ];

    packages = [
      (pkgs.python3.withPackages (python-pkgs: [
          python-pkgs.requests
      ]))
    ];

  nativeBuildInputs = with pkgs; [ pkg-config ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [ ]);

  shellHook = ''
      export CC=${pkgs.gcc}/bin/gcc
      export CXX=${pkgs.gcc}/bin/g++
  '';
}
