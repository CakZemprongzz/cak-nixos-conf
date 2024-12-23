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

        dive
        podman-tui
        podman-compose
        distrobox
        pciutils
        fastfetch

        jamesdsp

        vulkan-tools
        mangohud

        spice
        spice-gtk
        spice-protocol
        spice-vdagent
        (virt-manager.overrideAttrs (old: {
            nativeBuildInputs = old.nativeBuildInputs ++ [wrapGAppsHook];
            buildInputs = lib.lists.subtractLists [wrapGAppsHook] old.buildInputs ++ [
                gst_all_1.gst-plugins-base
                gst_all_1.gst-plugins-good
            ];
        }))
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
