{ config, lib, pkgs, ... } : {

  home.packages = with pkgs; [
    vesktop
    qbittorrent
    filezilla
    jellyfin-media-player
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = "mouse on";
    };
    btop.enable = true;
  };

}
