{ pkgs, ... }:

{
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    (pkgs.fetchFromGitHub {
      owner = "bradleyhodges";
      repo = "SFWindows";
      rev = "53cbc77150baa6222342aca231e4f55137b948af";
      hash = "sha256-PBp3jPUaNZvVDe/K/7TwZ41nBuD2YtM3aB/NF2056Q4=";
    })
  ];
}
