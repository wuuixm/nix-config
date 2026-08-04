{ config, pkgs, inputs, ... }:

{
  home.file.".local/share/fcitx5/rime" = {
    source = inputs.res-moqi-rime;
    recursive = true;
  };
  home.file.".local/share/fcitx5/rime/default.custom.yaml".text = ''
    patch:
      schema_list:
        - schema: moqi_wan_flypy
      ascii_composer:
        good_old_caps_lock: true
        switch_key:
          Shift_L: noop
          Shift_R: noop
          Control_L: noop
          Control_R: noop
          Caps_Lock: clear
  '';
}
