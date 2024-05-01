{ pkgs, lib, stdenvNoCC, fetchurl, fetchFromGitHub, requireFile, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "nerdfonts";
  version = "3.2.1";

  srcs = [
    (fetchFromGitHub {
      owner = "Karmenzind";
      repo = "monaco-nerd-fonts";
      rev = "master";
      hash = "sha256-QQBnt/aTq2skSk73VEjWZB0KqewOVRf5dfpnqN88aes";
    })
    (fetchurl {
      url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/JetBrainsMono.zip";
      hash = "sha256-ZZaSKquviHa7ZXw2pHAJrGjDiGYttF1KwFwlNsLwet4=";
    })
    (requireFile {
      name = "MonoLisa-Plus-2.013.zip";
      url = "https://www.monolisa.dev/";
      hash = "sha256-f22TrzWT7oaZd9v/dMPgIYmObQw8+kLEOix4ND7t0QM=";
    })
  ];

  nativeBuildInputs = [
    unzip
  ];

  buildInputs = [
    pkgs.nerd-font-patcher
  ];

  unpackPhase = ''
    sources=($srcs)

    cp -r ''${sources[0]}/fonts .
    unzip -o ''${sources[1]}
    unzip -o ''${sources[2]}
  '';

  buildPhase = ''
    runHook preBuild

    mkdir -p ./final
    cp fonts/* ./final
    cp JetBrainsMonoNerdFont-*.ttf ./final

    cd ttf
    for filename in ./MonoLisa*.ttf; do
      nerd-font-patcher --complete --out ../final --no-progressbars --quiet "$filename"
    done

    cd ..

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp ./final/*.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.nerdfonts.com/";
    description = "Nerd Fonts patches developer targeted fonts with a high number of glyphs (icons).";
    license = {
        shortName = "other";
        fullName = "Nerd Fonts Licenses";
        url = "https://github.com/ryanoasis/nerd-fonts/blob/master/LICENSE";
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
