{
    pkgs,
    ...
} : {
    environment.systemPackages = with pkgs; [
        # archives
        zip
        unzip
        p7zip
        unrar
        rar

        #filesystem
        ntfs3g
        exfat

        # misc
        libnotify
        xdg-utils
        git
        wget
        libarchive
        sof-firmware
    ];
}
