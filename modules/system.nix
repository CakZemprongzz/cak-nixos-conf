{ pkgs, lib, config, inputs,  ... } : {

  imports = [
    ./boot.nix
    ./environment.nix
    ./fonts.nix
    ./networking.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./users.nix
    ./virtualisation.nix
  ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "all" ];
    extraLocaleSettings = {
      LANG = "en_US.UTF-8";
      LC_NUMERIC = "id_ID.UTF-8";
      LC_TIME = "id_ID.UTF-8";
      LC_MONETARY = "id_ID.UTF-8";
      LC_PAPER = "id_ID.UTF-8";
      LC_MEASUREMENT = "id_ID.UTF-8";
    };
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  fileSystems = {
    "/" = { options = [ "compress=zstd:1" ]; };
    "/home" = { options = [ "compress=zstd:1" ]; };
    "/nix" = { options = [ "compress=zstd:1" "noatime" ]; };
  };
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowedUnfreePredicate = (_: true);
    };
  };
  nixpkgs.config.packageOverrides = pkgs: rec {
    wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
      patches = attrs.patches ++ [ ./eduroam.patch ];
    });
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  time.timeZone = "Asia/Jakarta";
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableAllFirmware = true;
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
