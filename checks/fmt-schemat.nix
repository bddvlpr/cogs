{
  stdenvNoCC,
  schemat,
}:
stdenvNoCC.mkDerivation {
  name = "fmt-schemat";
  src = ../.;

  buildInputs = [schemat];

  buildPhase = ''
    schemat -c "**/*.scm" > $out
  '';
}
