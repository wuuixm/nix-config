{ config, pkgs, inputs, ... }:

let
  rustToolchain = (inputs.rust-overlay.lib.mkRustBin { } pkgs).stable.latest.minimal.override {
    extensions = [ "rust-analyzer" "rust-src" "rustfmt" "clippy" ];
  };
in
{
  home.packages = [ rustToolchain ];
}
