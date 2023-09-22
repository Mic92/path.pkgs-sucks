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
        apps.default = self'.apps.benchmark;
        apps.benchmark.program = builtins.toString (pkgs.writeShellScript "benchmark" ''
          cd ${self}
          echo hello without pkgs.path
          time nix eval '.#hello-fast' --apply builtins.toString --no-eval-cache
          echo hello with pkgs.path
          time nix eval '.#hello-slow' --apply builtins.toString --no-eval-cache
        '');
        packages.hello-fast = pkgs.hello.overrideAttrs (old: {
          path = pkgs.writeText "not-path" "";
        });
        packages.hello-slow = pkgs.hello.overrideAttrs (old: {
          path = pkgs.path;
        });
      };
    });
}
