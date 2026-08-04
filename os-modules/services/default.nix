{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    neovim
    pciutils
    asusctl
    os-prober
    xwayland-satellite
  ];

  services.flatpak.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  programs.clash-verge = {
    enable = true;
    package = pkgs-unstable.clash-verge-rev;
    autoStart = true;
    serviceMode = true;
    tunMode = true;
  };

  programs.steam.enable = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
