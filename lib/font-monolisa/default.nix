{ pkgs, lib, stdenvNoCC, requireFile, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "monolisa";
  version = "2.013";

  src = requireFile {
    name = "MonoLisa-Plus-${version}.zip";
    url = "https://www.monolisa.dev/";
    hash = "sha256-f22TrzWT7oaZd9v/dMPgIYmObQw8+kLEOix4ND7t0QM=";
  };

  nativeBuildInputs = [
    unzip
  ];

  buildInputs = [
    pkgs.nerd-font-patcher
  ];

  buildPhase = ''
    runHook preBuild

    unzip $src

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp ttf/*.ttf $out/share/fonts/truetype

    cd ttf
    for filename in ttf/MonoLisa*.ttf; do
      nerd-font-patcher --complete --out $out/share/fonts/truetype --no-progressbars --quiet "$filename"
    done

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.monolisa.dev/";
    description = "A font family designed for software developers. Font follows function.";
    license = {
        shortName = "eula";
        fullName = "FaceType – End User License Agreement (EULA)";
        url = "https://www.monolisa.dev/license";
    };
    platforms = platforms.all;
    maintainers = [
        {
            name = "Vlad Zaharia";
            email = "hey@vlad.gg";
            github = "vladzaharia";
            githubId = 79390;
        }
    ];
  };
}