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
    "/swap".options = [ "noatime" ];
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
