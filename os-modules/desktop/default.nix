{ pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = false;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-term
    cosmic-player
  ];

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-cosmic
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = pkgs.lib.mkForce [ "cosmic" "gnome" "gtk" ];
    };
  };

  programs.niri.enable = true;

  console = {
    enable = true;
    font = "ter-u24b";
    packages = with pkgs; [ terminus_font ];
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      dur_file_path = "/etc/ly/blackhole.dur";
      dur_offset_alignment = "center";
      bigclock = "none";
      clock = "%Y-%m-%d %H:%M:%S";
      full_color = true;
      blank_box = true;
     };
  };

  environment.etc."ly/blackhole.dur".source = ./ly-themes/blackhole.dur;
}
