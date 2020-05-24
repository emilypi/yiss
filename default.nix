{ nixpkgs ? import <nixpkgs> {}
, compiler ? "default"
, doBenchmark ? false
}:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, binary, bytestring, containers
      , directory, edit-distance, filepath, hashable, HTTP, lens, mtl
      , network, optparse-applicative, parsec, regex-tdfa, stdenv, text
      , transformers, unix
      }:
      mkDerivation {
        pname = "yiss";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          base binary bytestring containers directory edit-distance filepath
          hashable HTTP lens mtl network parsec regex-tdfa text transformers
          unix
        ];
        executableHaskellDepends = [
          base bytestring directory filepath optparse-applicative text unix
        ];
        testHaskellDepends = [ base ];
        homepage = "https://github.com/emilypi/yiss";
        description = "Aww yiss!";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
