{ pkgs, lib, config, inputs, ...} : {

  security = {
    rtkit = {
      enable = true;
      };
    pam = {
      sshAgentAuth.enable = true;
      services = {
        login.kwallet.enable = true;
      };
    };
  };

}
