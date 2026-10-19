{config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    gh
    ripgrep
    fd
    unzip
    curl
    kitty
    rofi
    btop
    wlr-randr
    brightnessctl
    mako
    tmux
    awscli2
    ssm-session-manager-plugin
    bibata-cursors
    gzip
    gnutar
    codex
    helium
    hyprpaper
    grim
    slurp
    swappy
    nwg-look
    gsettings-desktop-schemas
    dconf
    coder
    mosh
    tailscale
    yazi
    fastfetch
    cider-2
    gram
  ];  

}
