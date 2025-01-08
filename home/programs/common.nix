{ config, lib, pkgs, ... }:

let
  #nixpkgsUnstable = config._module.args.nixpkgs-unstable;
in
{
  home.packages = with pkgs; [
    #(nixpkgsUnstable.packages.x86_64-linux.bottles)

    google-chrome
    bottles
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    vesktop
    vlc
    handbrake
    zoom-us
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      extraConfig = "mouse on";
    };
    btop.enable = true;
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
