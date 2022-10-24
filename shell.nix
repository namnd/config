{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6309e71200281b9d44dbe61621a95f486e7fee21.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    sumneko-lua-language-server
  ];
}
