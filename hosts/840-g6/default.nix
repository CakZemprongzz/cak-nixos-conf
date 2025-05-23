{ config, lib, pkgs, inputs, ... } : {

  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
    ];

  networking.hostName = "840-g6"; # Define your hostname.

  hardware = {
    graphics = {
      extraPackages = with pkgs; [
        intel-media-sdk
        intel-media-driver
      ];
      extraPackages32 = with pkgs; [
        intel-media-sdk
        intel-media-driver
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.intel
  ];

  #do this first
  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "kvm"
    "gccarch-skylake"
  ];

  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
