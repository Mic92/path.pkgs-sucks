{
  description = "Demonstration of pkgs.path beeing slow";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ lib, ... }: {
      systems = lib.systems.flakeExposed;
      perSystem = { self', pkgs, ... }: {
        apps.benchmark.program = builtins.toString (pkgs.writeShellScript "benchmark" ''
          cd ${self}
          echo fast
          time nix eval '.#hello-fast' --apply builtins.toString --no-eval-cache
          echo slow
          time nix eval '.#hello-slow' --apply builtins.toString --no-eval-cache
        '');
        packages.hello-fast = pkgs.hello.overrideAttrs (old: {
          path = pkgs.writeText "hello-slow.sh" "";
        });
        packages.hello-slow = pkgs.hello.overrideAttrs (old: {
          path = pkgs.path;
        });
      };
    });
}
