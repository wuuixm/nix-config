{ pkgs, ... }:

{
  users.users.wuuixm = {
    isNormalUser = true;
    password = "123";
    description = "wuuixm";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" "input" "libvirtd" "kvm"];
    shell = pkgs.fish;
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
