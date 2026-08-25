{ config, lib, pkgs, inputs, ... }:

let
  # Launch XFCE inside its own D-Bus session. Without this, an RDP login
  # collides with a console login of the same user (xfce4-session is
  # single-instance per bus) and the session dies instantly -> blank screen.
  xrdpXfceSession = pkgs.writeShellScript "xrdp-xfce-session" ''
    export XDG_SESSION_TYPE=x11
    export XDG_CURRENT_DESKTOP=XFCE
    exec ${pkgs.dbus}/bin/dbus-run-session -- ${pkgs.xfce.xfce4-session}/bin/xfce4-session
  '';
in

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
    ];

  networking.hostName = "nixos-test";

  # ------------------------------------------------------------------
  # Lightweight test VM: no gaming stack (cak.gaming.enable = false),
  # zen kernel, XFCE desktop instead of Plasma 6.
  # ------------------------------------------------------------------

  cak.gaming.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  services.displayManager.sddm.wayland.enable = lib.mkForce false;
  services.desktopManager.plasma6.enable = lib.mkForce false;
  services.xserver.desktopManager.xfce.enable = true;

  # ------------------------------------------------------------------
  # Remote desktop (RDP)
  # ------------------------------------------------------------------

  services.xrdp = {
    enable = true;
    openFirewall = true; # opens TCP 3389
    defaultWindowManager = "${xrdpXfceSession}";
  };
  # xrdp auto-generates a self-signed TLS cert on first start.
  # NOTE: use RDP or the console/Spice display, not both logged in at once.

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # compressed zram swap on top of the 8G swap partition (small VM)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Virtio-GPU: the guest needs nothing extra (mesa drives virtio-gpu
  # out of the box); in virt-manager set Video model = "virtio"
  # (and 3D acceleration if wanted -> requires /dev/dri/renderD128).

  system.copySystemConfiguration = false;

  system.stateVersion = "24.11";
}
