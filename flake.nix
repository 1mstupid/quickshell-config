{
  description = "Quickshell configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.writeShellApplication {
            name = "quickshell-config";

            runtimeInputs = with pkgs; [
              # Quickshell + Qt
              quickshell
              qt6.qtbase
              qt6.qtdeclarative
              kdePackages.qtmultimedia

              # CLI tools used by the config
              bash
              coreutils
              gnugrep
              procps
              networkmanager
              findutils
              util-linux
            ];

            text = ''
              exec quickshell -p ${self}/shell.qml "$@"
            '';
          };
        }
      );
    };
}
