{pkgs, ...}: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        domain = "gfn.myamusashi.com";
        root_url = "http://gfn.myamusashi.com";
        serve_from_sub_path = true;
      };
      security = {
        allow_embedding = true;
        cookie_secure = true;
        cookie_samesite = "lax";
      };
    };
  };

  services.httpd.virtualHosts."gfn.myamusashi.com" = {
    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:3000/";
        extraConfig = ''
          ProxyPreserveHost On
          RequestHeader set X-Forwarded-Proto "https"
          RequestHeader set X-Forwarded-Host "gfn.myamusashi.com"
          Header always set Access-Control-Allow-Origin "*"
          Header always set Access-Control-Allow-Methods "GET, POST, OPTIONS, PUT, DELETE"
          Header always set Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept, Authorization"
        '';
      };
    };
  };

  networking.hosts = {
    "127.0.0.1" = ["gfn.myamusashi.com"];
  };
}
