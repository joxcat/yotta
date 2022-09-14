{
  description = "yotta in a flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }@intputs:
    utils.lib.eachSystem [ utils.lib.system.x86_64-linux ] (system: 
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = {
          default = import ./default.nix { inherit pkgs; };
        }; 
        devShell = import ./shell.nix { inherit pkgs; };
      }
    );
}
