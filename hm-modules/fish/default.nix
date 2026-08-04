{ config, pkgs, lib, mySecrets, ... }:
let

  modulesDir = ../.;

  manualEditor = null;
  userEditor = config.home.sessionVariables.EDITOR or null;

  editorCmd = 
    if manualEditor != null then manualEditor
    else if userEditor != null then userEditor
    else "vim";

  moduleDirNames =
    lib.attrNames (
      lib.filterAttrs (name: type: type == "directory") (builtins.readDir modulesDir)
    );

  moduleAbbrs = lib.listToAttrs (map (name: {
    name = "i${name}";
    value = "${editorCmd} ~/nixos-Gardenia/hm-modules/${name}/default.nix";
  }) moduleDirNames);

in
{
  programs.fish = {
    enable = true;

    shellInit = ''
      if test -f ${mySecrets.getPath "github-token"}
        set -gx GITHUB_TOKEN (cat ${mySecrets.getPath "github-token"} | tr -d '\n')
      end
    '';

    shellAliases = { };
    interactiveShellInit = ''
      set -g fish_greeting ""
      set -g fish_key_bindings fish_vi_key_bindings
      fnm env --use-on-cd --shell fish | source
    '';
    functions = {
      fish_user_key_bindings = ''
        bind -M insert jj 'set fish_bind_mode default; commandline -f backward-char; commandline -f repaint'
        bind -M default v edit_command_buffer
      '';
    };

    shellAbbrs = moduleAbbrs // {
      zed = "zeditor";
      nrs = "niri-session";
      bp = "btop";
      ff = "fastfetch";
      mat = "mdcat";
      gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      oc = "opencode";
      upd = "nix flake update --flake ~/nixos-Gardenia";
      rd = "sudo nixos-rebuild switch --flake ~/nixos-Gardenia#Gardenia";
      ips = "~/nixos-Gardenia/tools/edit-password";
      ifk = "${editorCmd} ~/nixos-Gardenia/flake.nix";
      ihm = "${editorCmd} ~/nixos-Gardenia/hm-modules/default.nix";
      ish = "${editorCmd} ~/nixos-Gardenia/hm-modules/fish/default.nix";
    };
  };
}
