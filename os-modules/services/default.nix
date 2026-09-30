{ pkgs, pkgs-unstable, inputs, ... }:

{
  imports = [ inputs.nyx.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    neovim
    pciutils
    asusctl
    os-prober
    xwayland-satellite
    mihomo
  ];

  services.flatpak.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = false;
    openFirewall = true;
    capSysAdmin = true;  
  };

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  programs.nyx = {
    enable = true;
    service = {
      enable = true;
      user = "wuuixm";
    };
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
