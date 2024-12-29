{ pkgs, lib, config, inputs, ...} : {

  users.users.cak = {
    isNormalUser = true;
    createHome = true;
    initialPassword = "12345";
    extraGroups = [ "wheel" "libvirtd" "podman" "networkmanager" ];
    name = "cak";
    home = "/home/cak";
  };

}
