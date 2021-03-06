{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "mpd-mpris";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "natsukagami";
    repo = pname;
    rev = "v${version}";
    sha256 = "19sz1ykdzradhpdwdvvxh9scp5sv2i072qircs0q4374cdgccfbb";
  };

  modSha256 = "1a95kfy8w952269x4llbl0afyxr5fjkg30mxsn81zdh5wr8gabwh";

  subPackages = [ "cmd/${pname}" ];

  postInstall = ''
    substituteInPlace mpd-mpris.service \
      --replace /usr/bin $out/bin
    mkdir -p $out/lib/systemd/user
    cp mpd-mpris.service $out/lib/systemd/user
  '';

  meta = with stdenv.lib; {
    description = "An implementation of the MPRIS protocol for MPD";
    homepage = "https://github.com/natsukagami/mpd-mpris";
    license = licenses.mit;
    maintainers = with maintainers; [ doronbehar ];
    platforms = platforms.linux;
  };
}

