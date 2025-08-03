{ pkgs, lib, config, inputs, ...} : {

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
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
    scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
  };

}
