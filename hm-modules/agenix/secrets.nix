let
  userKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDBXrSJyiiD2r+dLgCY7tHU/wufQvFeaixkvauSibHb wuuixm@outlook.com";
in
{
  "keys/aria2-rpc-secret.age".publicKeys = [ userKey ];
  "keys/github-token.age".publicKeys = [ userKey ];
}
