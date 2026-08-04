{ config, pkgs, inputs, ... }:

let
  rustToolchain = (inputs.rust-overlay.lib.mkRustBin { } pkgs).stable.latest.default.override {
    extensions = [ "rust-analyzer" "rust-src" ];
  };
in
{
  home.packages = [ rustToolchain ];
}
