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

    fonts.packages=with pkgs; [
        noto-fonts
        noto-fonts-lgc-plus
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        noto-fonts-emoji-blob-bin
        noto-fonts-monochrome-emoji
    ];

}
