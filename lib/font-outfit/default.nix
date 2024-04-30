{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "outfit";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "Outfitio";
    repo = "Outfit-Fonts";
    rev = "${version}";
    hash = "sha256-d12SnIhD5LdrgZYH7zzQ8otnRyp45VTCC9vEXVsVKLY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp fonts/ttf/*.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/Outfitio/Outfit-Fonts/";
    description = "The most on-brand typeface";
    license = licenses.ofl;
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