{
  stdenvNoCC,
  cargo,
  rustfmt,
}:
stdenvNoCC.mkDerivation {
  name = "fmt-rustfmt";
  src = ../.;

  buildInputs = [cargo rustfmt];

  buildPhase = ''
    cargo fmt --check > $out
  '';
}
