{ pkgs, lib, config, inputs, ... } : {

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ 51820 ];
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
    networkmanager = {
      enable = true;
    };
    wg-quick.interfaces.wg0.configFile = "/home/cak/wireguard-key/wg0.conf";
  };

}
