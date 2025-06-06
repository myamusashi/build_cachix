{
  config,
  pkgs,
  ...
}: {
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    port = 5500;
    secretKeyFile = config.sops.secrets.nix-serve_secrets.path;
  };

  services.atticd = {
    enable = false;
    environmentFile = "/etc/attic.env";
    settings = {
      listen = "[::1]:4040";
      database = {
        url = "postgresql:///attic?host=/run/postgresql";
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = ["nextcloud"];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/nextcloud 0750 nextcloud nextcloud - -"
    "d /var/lib/nextcloud/config 0750 nextcloud nextcloud - -"
    "d /var/lib/nextcloud/data 0750 nextcloud nextcloud - -"
  ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "cloud.myamusashi.com";
    config = {
      adminpassFile = config.sops.secrets.nextcloud_admin_pass.path;
      dbtype = "pgsql";
      adminuser = "admin";
    };
    settings = {
      trusted_domains = [
        "cloud.myamusashi.com"
        "cloud.myamusashi.space"
      ];
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks notes;
    };
    database.createLocally = true;
    configureRedis = true;
    autoUpdateApps.enable = true;
    extraAppsEnable = true;
  };

  services.nginx.virtualHosts."cloud.myamusashi.com".listen = [
    {
      addr = "127.0.0.1";
      port = 9010;
    }
  ];

  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "admin@email.tld";
    extraModules = [
      "proxy"
      "proxy_http"
    ];

    extraConfig = ''
      DirectoryIndex index.html index.php
    '';

    virtualHosts = let
      configFile = pkgs.writeText "config.inc.php" ''
        <?php
        /* Authentication type */
        $cfg['Servers'][1]['auth_type'] = 'http';
        /* Server parameters */
        $cfg['Servers'][1]['host'] = 'localhost';
        $cfg['Servers'][1]['compress'] = false;
        $cfg['Servers'][1]['AllowNoPassword'] = false;
      '';
      phpmyadminPkg = pkgs.callPackage ./pkg.nix {inherit configFile;};
    in {
      "pma.myamusashi.com" = {
        documentRoot = phpmyadminPkg;
        extraConfig = ''
          <Directory "${phpmyadminPkg}">
            Options -Indexes
          </Directory>
        '';
      };
      "cache.myamusashi.com" = {
        documentRoot = "/var/www/nix-cache-ui/src";
        extraConfig = ''
          ProxyPass "/nix-cache-info" "http://127.0.0.1:5500/nix-cache-info"
          ProxyPassReverse "/nix-cache-info" "http://127.0.0.1:5500/nix-cache-info"
          ProxyPass "/nar" "http://127.0.0.1:5500/nar"
          ProxyPassReverse "/nar" "http://127.0.0.1:5500/nar"

          ProxyPass "/api/nix-builds" "http://127.0.0.1:3000/api/nix-builds"
          ProxyPassReverse "/api/nix-builds" "http://127.0.0.1:3000/api/nix-builds"
          <LocationMatch "^/(nar|nix-cache-info|api)">
             Header set Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0"
             ExpiresActive On
             ExpiresDefault "access"
          </LocationMatch>
        '';
      };
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        PROTOCOL = "http+unix";
        DOMAIN = "git.myamusashi.space";
        ROOT_URL = "https://git.myamusashi.space";
        HTTP_ADDR = "/run/forgejo/forgejo.sock";
        HTTP_PORT = 3000;
        SSH_DOMAIN = "git.myamusashi.space";
      };
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      session = {
        COOKIE_SECURE = true;
      };
      "markup.jupyter" = {
        ENABLED = true;
        FILE_EXTENSIONS = ".ipynb";
        RENDER_COMMAND = "${pkgs.python312Packages.nbconvert}/bin/jupyter-nbconvert --to html --stdout";
        IS_INPUT_FILE = true;
      };
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "waltz";

  services.logind.lidSwitchExternalPower = "ignore";

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
    localRoot = "/var/ftp";
    extraConfig = ''
      local_umask=007
    '';
  };
}
