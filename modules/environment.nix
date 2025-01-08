{ pkgs, lib, config, inputs, ... }:

let
  nixpkgsUnstable = inputs.nixpkgs-unstable.legacyPackages."x86_64-linux";
in
{
  environment = {
    systemPackages = with pkgs; [

      gcc
      vlc
      handbrake
      #bottles
      (nixpkgsUnstable.bottles)
      google-chrome
      libreoffice-qt
      hunspell
      hunspellDicts.en_US

      # Archives
      zip
      unzip
      p7zip
      unrar
      rar

      # Filesystem
      ntfs3g
      exfat

      # Miscellaneous utilities
      libnotify
      xdg-utils
      git
      wget
      libarchive
      sof-firmware
      dive
      podman-tui
      podman-compose
      distrobox
      pciutils
      fastfetch
      jamesdsp
      vulkan-tools
      mangohud

      # Spice tools
      spice
      spice-gtk
      spice-protocol
      spice-vdagent

      # Virtualization tools
      (virt-manager.overrideAttrs (old: {
        nativeBuildInputs = old.nativeBuildInputs ++ [wrapGAppsHook];
        buildInputs = lib.lists.subtractLists [wrapGAppsHook] old.buildInputs ++ [
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good
        ];
      }))
    ];

    variables.EDITOR = "nano";
  };

}
