{
  description = "Examera dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            go
            flutter
            postgresql_15
            gnumake
          ];

          # shellHook = ''
          #   export GOPATH="$HOME/go";
          #   export PATH="$GOPATH/bin:$PATH";
          #   export DATABASE_URL="postgres://examera:examera_pass@localhost:5432/examera_db?sslmode=disable";
          # '';
        };
      }
    );
}
