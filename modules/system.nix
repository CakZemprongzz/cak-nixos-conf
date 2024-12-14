{
	pkgs,
	lib,
	config,
	...
}: {

  imports = [
    ./firewall.nix
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     #keyMap = "us";
     useXkbConfig = true; # use xkb.options in tty.
   };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  services.xserver.xkb.layout = "us";

  services.pipewire = {
     enable = true;
     pulse.enable = true;
   };


   users.users.mccak = {
     isNormalUser = true;
     initialPassword = "12345";
     extraGroups = [ "wheel" ];
     packages = with pkgs; [
       tree
     ];
   };

  services.openssh.enable = true;

  fileSystems = {
        "/".options = [ "compress=zstd" ];
        "/home".options = [ "compress=zstd" ];
        "/nix".options = [ "compress=zstd" "noatime" ];
        };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowedUnfreePredicate = (_: true);
    };
  };

  environment.variables.EDITOR = "nano";
}
