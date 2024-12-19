{
  pkgs,
  config,
  username,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
      #profiles.${config.home.username} = {};
    };
  };
}
