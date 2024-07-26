{
  stdenvNoCC,
  alejandra,
}:
stdenvNoCC.mkDerivation {
  name = "fmt-alejanrda";
  src = ../.;

  buildInputs = [alejandra];

  buildPhase = ''
    alejandra -c . > $out
  '';
}
