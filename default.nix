{ nixpkgs ? import <nixpkgs> {} }:
let
  # get our custom plugin enabled ghc
  ghc = (nixpkgs.callPackage ./ghc {}).pluginGhc;
  # package expressions
  data-bitcode = ghc.callPackage ./data-bitcode { };
  data-bitcode-llvm = ghc.callPackage ./data-bitcode-llvm { inherit data-bitcode; };
  data-bitcode-edsl = ghc.callPackage ./data-bitcode-edsl { inherit data-bitcode data-bitcode-llvm; };
  data-bitcode-plugin = ghc.callPackage ./data-bitcode-plugin { inherit data-bitcode-edsl data-bitcode-llvm; };
  # setup a ghc with the plugin in the package database.
  pluginGhc = ghc.ghcWithPackages (pkgs: [data-bitcode-plugin]);
in
# Create an empty derivation, that has the
# custom ghc as well as llvm available.
nixpkgs.pkgs.stdenv.mkDerivation {
  name = "data-bitcode-plugin-env";
  buildInputs = [ pluginGhc nixpkgs.pkgs.llvm_39 ];
}
