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
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }
            ).fd
          ];
        };
        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

}
