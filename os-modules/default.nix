{ ... }:
let
  entries = builtins.readDir ./.;
  allNames = builtins.attrNames entries;
  dirNames = builtins.filter (name: entries.${name} == "directory") allNames;
  autoImports = map (dir: ./. + "/${dir}") dirNames;
in
{
  imports = [
    ../hardware-configuration.nix
  ] ++ autoImports;
}
