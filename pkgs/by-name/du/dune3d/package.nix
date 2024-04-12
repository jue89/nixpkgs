{ gcc13Stdenv
, lib
, cmake
, eigen
, fetchFromGitHub
, glm
, gtkmm4
, libepoxy
, librsvg
, libuuid
, gobject-introspection
, meson
, mimalloc
, ninja
, opencascade-occt
, pkg-config
, python3
, range-v3
, wrapGAppsHook
}:

let
  stdenv = gcc13Stdenv;
  pythonEnv = python3.withPackages(ps: [ ps.pygobject3 ]);
in
stdenv.mkDerivation rec {
  pname = "dune3d";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "dune3d";
    repo = "dune3d";
    rev = "eb62dd2e2225a9bd27f309bd586e6cb9e48c3d79";
    hash = "sha256-3UDKksFWHNF36kpC4kNUeLmwH/xRPwdGSnswR3lA9nA=";
  };

  nativeBuildInputs = [
    meson
    ninja
    gobject-introspection
    pkg-config
    pythonEnv
    wrapGAppsHook
  ];

  buildInputs = [
    cmake
    eigen
    glm
    gtkmm4
    libepoxy
    librsvg
    libuuid
    mimalloc
    opencascade-occt
    range-v3
  ];

  env.CASROOT = opencascade-occt;

  meta = with lib; {
    description = "Dune 3D is a parametric 3D CAD application";
    homepage = "https://dune3d.org/";
    maintainers = with maintainers; [ jue89 ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
