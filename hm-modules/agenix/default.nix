{ config, lib, pkgs, inputs, ... }:

let
  rawSecretsMap = import ./secrets.nix;

  ageFiles = builtins.attrNames rawSecretsMap;

  toSecretName = path: lib.removeSuffix ".age" (builtins.baseNameOf path);

  generateAgeSecrets = builtins.listToAttrs (map (relPath: {
    name = toSecretName relPath;
    value = {
      file = ./. + "/${relPath}";
    };
  }) ageFiles);
in
{
  imports = [ inputs.agenix.homeManagerModules.default ];

  age.identityPaths = [
    "${config.home.homeDirectory}/.ssh/id_ed25519"
  ];

  age.secretsDir = "$XDG_RUNTIME_DIR/agenix";

  age.secrets = generateAgeSecrets;

  home.packages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];

  _module.args.mySecrets = {
    getPath = name: config.age.secrets.${name}.path;
    getValue = name: "$(cat ${config.age.secrets.${name}.path} 2>/dev/null | ${pkgs.coreutils}/bin/tr -d '\\n')";
  };
}
