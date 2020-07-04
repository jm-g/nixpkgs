{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "dpic";
  version = "2020.06.01";

  src = fetchurl {
    url = "https://ece.uwaterloo.ca/~aplevich/dpic/${pname}-${version}.tar.gz";
    sha256 = "1gbkpbjwjaaifxff8amm9b47dynq4l4698snjdgnn4flndw62q88";
  };

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  makeFlags = [ "CC=${stdenv.cc.outPath}/bin/cc" ];

  installPhase = ''
    mkdir -p $out/bin
    cp -fv dpic $out/bin
  '';

  meta = {
    homepage = "https://ece.uwaterloo.ca/~aplevich/dpic/";
    description = "An implementation of the pic little language for creating drawings";
    license = stdenv.lib.licenses.bsd2;
    maintainers = [ stdenv.lib.maintainers.aespinosa ];
    platforms = stdenv.lib.platforms.all;
  };
}

