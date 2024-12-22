{ pkgs, lib, config, ... }: {
  imports = [
    ./firewall.nix
    ./syspkgs.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;

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

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    openssh.enable = true;

    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
  };


  security = {
    rtkit = {
      enable = true;
      };
    pam = {
      sshAgentAuth.enable = true;
    };
  };
  networking.networkmanager.enable = true;

  users.users.cak = {
    isNormalUser = true;
    createHome = true;
    initialPassword = "12345";
    extraGroups = [ "wheel" "libvirtd" "podman" "networkmanager" ];
    name = "cak";
    home = "/home/cak";
  };

  fileSystems = {
    "/" = { options = [ "compress=zstd:1" ]; };
    "/home" = { options = [ "compress=zstd:1" ]; };
    "/nix" = { options = [ "compress=zstd:1" "noatime" ]; };
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowedUnfreePredicate = (_: true);
  };

  environment.variables.EDITOR = "nano";

  programs = {
    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
    kdeconnect.enable = true;
    virt-manager.enable = true;
    ssh = {
      startAgent = true;
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  time.timeZone = "Asia/Jakarta";

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableAllFirmware = true;
  };
}
