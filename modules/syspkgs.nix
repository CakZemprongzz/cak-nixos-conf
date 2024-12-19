{
    pkgs,
    ...
} : {

    environment.systemPackages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.en_US
        git
        wget
        bottles
    ];

}
