{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    gdb
    bullet
    openssl
    zlib
    boost
    glfw-wayland
    opencv
    cmake
    wayland
    libxkbcommon
    wayland-scanner
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    qt6.full
  ];

  nativeBuildInputs = with pkgs; [ pkg-config ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    wayland
    libxkbcommon
    wayland-scanner
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
  ]);

  shellHook = ''
      export CC=${pkgs.gcc}/bin/gcc
      export CXX=${pkgs.gcc}/bin/g++
  '';
}
