{ lib, pkgs, ... } : {

  home.packages = with pkgs; [
    google-chrome
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    bottles
    vesktop
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = "mouse on";
    };
    btop.enable = true; # replacement of htop/nmon
    ssh.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };

  services = {

  };

}
