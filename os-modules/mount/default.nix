{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.ntfs3g ];

  fileSystems."/mnt/win11" = {
    device = "/dev/disk/by-uuid/4B933B84703E8AC7";
    fsType = "ntfs-3g";
    options = [
      "rw"             
      "uid=1000"       
      "gid=100"        
      "umask=022"      
      "windows_names"   
      "nofail"         
    ];
  };
}
