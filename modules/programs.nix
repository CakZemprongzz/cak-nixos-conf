{ pkgs, lib, config, inputs, ... }: {

  programs = {
    firefox = {
      enable = true;
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
    kdeconnect.enable = true;
    virt-manager.enable = true;
    partition-manager.enable = true;
    ssh = {
      startAgent = true;
      extraConfig = ''
        Host github.com
          IdentityFile ~/Downloads/SSH-Keys/github/id_ed25519
      '';
    };
    # gaming stack (steam/gamescope/gamemode/OBS) lives in modules/gaming.nix
    # behind the cak.gaming.enable toggle
  };

}
