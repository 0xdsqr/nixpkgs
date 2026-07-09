{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "codex-desktop";
  version = "26.623.141536";

  src = fetchurl {
    url = "https://persistent.oaistatic.com/codex-app-prod/Codex-darwin-arm64-${finalAttrs.version}.zip";
    hash = "sha256-2UjcNrg1j1opJLAz+/CDmO6nhg3J6Xy1q5s1RJAoOgo=";
  };

  nativeBuildInputs = [ unzip ];

  dontFixup = true;

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications" "$out/bin"
    cp -a Codex.app "$out/Applications"
    ln -s "$out/Applications/Codex.app/Contents/MacOS/Codex" "$out/bin/Codex"

    runHook postInstall
  '';

  meta = {
    description = "AI assistant for work and code";
    homepage = "https://chatgpt.com/codex/";
    changelog = "https://developers.openai.com/codex/changelog";
    downloadPage = "https://chatgpt.com/download/";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ dsqr ];
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "Codex";
  };
})
