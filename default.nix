{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  inherit (pkgs) stdenv cmake openssl;
  pname = "gost-engine";
  version = "nix";

  src = ./.;

  cmakeFlags = [ "-DOPENSSL_ENGINES_DIR=engine/" ];
  nativeBuildInputs = [ cmake openssl ];
  buildInputs = [ ];

  postInstall = ''
    mkdir -p $out/lib
    cp engine/gost.so $out/lib/
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/gost-engine/engine;
    description = ''
      A reference implementation of the Russian GOST crypto algorithms for OpenSSL
    '';
    maintainers = with maintainers; [ ];
    platforms = with platforms; linux;
  };
}
