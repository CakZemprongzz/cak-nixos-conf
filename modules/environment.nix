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
      mpv

      # Archives
      zip
      unzip
      p7zip
      unrar
      rar

      # Filesystem
      ntfs3g
      exfat
      nfs-utils
      exfatprogs
      btrfs-progs
      f2fs-tools

      # Miscellaneous utilities
      libnotify
      xdg-utils
      git
      wget
      libarchive
      sof-firmware
      podman
      podman-compose
      distrobox
      pciutils
      fastfetch
      jamesdsp
      vulkan-tools
      mangohud
      kdePackages.filelight
      kdePackages.xdg-desktop-portal-kde
      tio
      protonup-qt

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
    etc.hosts.mode = "0644";
    variables.EDITOR = "nano";
    plasma6.excludePackages = with pkgs.kdePackages; [
      oxygen
    ];

  };

}
