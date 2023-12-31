{
  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system}; 
  in {
    packages.${system} = rec {
      # Note: this is extremely naive
      project = pkgs.writeShellApplication {
        name = "project";
        runtimeInputs = [pkgs.yarn];
        text = ''
          yarn install
          yarn start
        '';
      };
      default = project;
    };
    devShells.${system} = {
      default = pkgs.mkShell {
        nativeBuildInputs = [pkgs.yarn];
      };
    };
  };
}
