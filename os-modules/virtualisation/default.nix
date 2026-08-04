{ lib, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      # vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  programs.virt-manager.enable = true;
}
