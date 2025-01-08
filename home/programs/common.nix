{ config, lib, pkgs, ... } : {

  home.packages = with pkgs; [
    vesktop
    zoom-us
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = "mouse on";
    };
    btop.enable = true; # replacement of htop/nmon
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };

}
