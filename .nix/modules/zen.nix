{ pkgs, zen, ... }:

# Source: https://github.com/0xc000022070/zen-browser-flake/issues/115
let
  system = pkgs.stdenv.hostPlatform.system;
  sineSources = (builtins.fromJSON (builtins.readFile "${zen}/sources.json")).addons.sine;
  bootloader = pkgs.fetchFromGitHub {
    inherit (sineSources.bootloader) owner repo rev hash;
  };

  zenWithSine = zen.packages.${system}.beta-unwrapped.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      for libdir in "$out"/lib/zen-bin-*; do
        chmod -R u+w "$libdir/defaults"
        install -m 644 ${bootloader}/program/config.js "$libdir/config.js"
        install -D -m 644 \
          ${bootloader}/program/defaults/pref/config-prefs.js \
          "$libdir/defaults/pref/config-pref.js"
      done
    '';
  });

  wrapZen = import "${zen}/wrap-zen.nix" pkgs.wrapFirefox;
in
{
  environment.systemPackages = [ (wrapZen zenWithSine { icon = "zen-browser"; }) ];
}
