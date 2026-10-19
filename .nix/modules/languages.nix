{config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    #languages  
    rustc
    cargo
    nodejs
    python3
    clang
    
    #lsps
    clang-tools
    nixd
    nixfmt
    vscode-langservers-extracted
    lua-language-server
    svelte-language-server
    vtsls
    rust-analyzer

  ];
}
