{ pkgs, lib, config, inputs, ...} : {

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

}
