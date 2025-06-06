{lib, ...}: {
  home.activation = {
    # iconLinkAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #   ln -sf $HOME/.nix-profile/share/icons/* $HOME/.icons
    # '';

    hyprScriptsLinkAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.dots/home/users/myamusashi/programs/hypr/scripts /tmp/scripts
    '';

    # themeLinkAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #   ln -sf $HOME/.nix-profile/share/themes/* $HOME/.themes
    # '';

    discordCSS = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.dots/scripts/discord_theme.css $HOME/.config/vesktop/settings/quickCss.css
    '';
  };
}
