{ lib, stdenvNoCC, fetchzip, fetchFromGitHub, requireFile, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "nerdfonts";
  version = "3.2.1";

  jetbrains_src = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/JetBrainsMono.zip";
    hash = "sha256-d12SnIhD5LdrgZYH7zzQ8otnRyp45VTCC9vEXVsVKLY=";
  };
  src = fetchFromGitHub {
    owner = "Karmenzind";
    repo = "monaco-nerd-fonts";
    rev = "master";
    hash = "sha256-QQBnt/aTq2skSk73VEjWZB0KqewOVRf5dfpnqN88aes";
  };
  monolisa_src = requireFile {
    name = "MonoLisa-Plus-2.013-NF.zip";
    url = "https://www.monolisa.dev/";
    hash = "sha256-6V7tVzYuGOuttHv/3QXATh2M0GkVibimuR+SDi47jBQ=";
  };

  nativeBuildInputs = [
    unzip
  ];

  buildPhase = ''
    runHook preBuild

    ls .
    unzip $jetbrains_src
    unzip $monolisa_src

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp **/*.ttf $out/share/fonts/truetype

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