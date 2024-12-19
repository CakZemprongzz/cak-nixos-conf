{
	pkgs,
	lib,
	config,
	...
}: {

  imports = [
    ./firewall.nix
    ./syspkgs.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n = {
    supportedLocales = [ "en_US.UTF-8/UTF-8" "id_ID.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LANG = "en_US.UTF-8";
      LC_MESSAGES = "id_ID.UTF-8";
      LC_NUMERIC= "id_ID.UTF-8";
      LC_TIME = "id_ID.UTF-8";
      LC_MONETARY = "id_ID.UTF-8";
      LC_PAPER = "id_ID.UTF-8";
      LC_MEASUREMENT = "id_ID.UTF-8";

    };
  };

  console = {
     font = "Lat2-Terminus16";
     #keyMap = "us";
     useXkbConfig = true; # use xkb.options in tty.
   };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  security.pam.services.sddm.enableKwallet = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb.layout = "us";

  time.timeZone = "Asia/Jakarta";

  networking.networkmanager.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.cak = {
    isNormalUser = true;
    initialPassword = "12345";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.openssh.enable = true;

  fileSystems = {
    "/".options = [ "compress=zstd:1" ];
    "/home".options = [ "compress=zstd:1" ];
    "/nix".options = [ "compress=zstd:1" "noatime" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowedUnfreePredicate = (_: true);
    };
  };

  environment.variables.EDITOR = "nano";
}
