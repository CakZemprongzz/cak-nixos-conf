{
    pkgs,
    ...
} : {

    environment.systemPackages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.en_US
        hunspellDicts.id_ID
        git
        wget
    ];

}
