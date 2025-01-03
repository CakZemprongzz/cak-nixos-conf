{ pkgs, lib, config, inputs, ... } : {

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
    networkmanager.enable = true;
  };

}
