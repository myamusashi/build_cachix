{pkgs, ...}: {
  official-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "864a0210d9ba1e8eb925160c2e2a25342031d8d3";
    hash = "sha256-m3709h7/AHJAtoJ3ebDA40c77D+5dCycpecprjVqj/k=";
  };

  mime-preview = pkgs.fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "mime-preview.yazi";
    rev = "5ee0e78d7a46b756b77bec029722d31823869f08";
    hash = "sha256-utK+Ng0M5BvxAH/Cjz6/Gg6vc+cD9bwJxiQTerOhnW8=";
  };

  mime-ext = pkgs.fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "mime-ext.yazi";
    rev = "47b5f85b0b6156f689641132eb9d29f7301b9b6a";
    hash = "sha256-+hxHKEhvpvHcTrb56BY7cuvzKYO3ywbvdY4dmPQR4pU=";
  };

  mediainfo = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "9629b1e85c3757c834ec83fb7d931982c55f4c3f";
    hash = "sha256-EDEIiZJy/RfXVaLNsKDeklH4qY2h+js2m0y6VSAjPkk=";
  };

  office = pkgs.fetchFromGitHub {
    owner = "macydnah";
    repo = "office.yazi";
    rev = "d1e3e51857c109fbfc707ab0f9f383dc98b9795f";
    hash = "sha256-ORcexu1f7hb7G4IyzQIfGlCkH3OWlk4w5FtZrbXkR40=";
  };

  eza-preview = pkgs.fetchFromGitHub {
    owner = "ahkohd";
    repo = "eza-preview.yazi";
    rev = "6575a9a4806d8dc96ac75adf28791155551804fb";
    hash = "sha256-RwJu79bjdgmKbRaDH++y8wreBKdGGwbyGOx4G/px2PE=";
  };

  glow = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "2da96e3ffd9cd9d4dd53e0b2636f83ff69fe9af0";
    hash = "sha256-4krck4U/KWmnl32HWRsblYW/biuqzDPysrEn76buRck=";
  };

  hexyl = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "main";
    hash = "sha256-ly/cLKl2y3npoT2nX8ioGOFcRXI4UXbD9Es/5veUhOU=";
  };

  ouch = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "2496cd9ac2d1fb52597b22ae84f3af06c826a86d";
    hash = "sha256-OsNfR7rtnq+ceBTiFjbz+NFMSV/6cQ1THxEFzI4oPJk=";
  };

  rich-preview = pkgs.fetchFromGitHub {
    owner = "AnirudhG07";
    repo = "rich-preview.yazi";
    rev = "fdcf37320e35f7c12e8087900eebffcdafaee8cb";
    hash = "sha256-HO9hTCfgGTDERClZaLnUEWDvsV9GMK1kwFpWNM1wq8I=";
  };

  yatline = pkgs.fetchFromGitHub {
    owner = "imsi32";
    repo = "yatline.yazi";
    rev = "655facb7c31ddcf96a05185c65dd5b89d5954f2b";
    hash = "sha256-fjapFEaM5ORoJJivrzKxwPM9pe6B9UkVqPfOsUPxpEg=";
  };

  lazygit = pkgs.fetchFromGitHub {
    owner = "Lil-Dank";
    repo = "lazygit.yazi";
    rev = "9f924e34cde61d5965d6d620698b0b15436c8e08";
    hash = "sha256-ns9DzIdI2H3IuCByoJjOtUWQQB9vITxmJ/QrYt+Rdao=";
  };

  githead = pkgs.fetchFromGitHub {
    owner = "llanosrocas";
    repo = "githead.yazi";
    rev = "23750247d59da485e4b5257ad5e83837bb86a685";
    hash = "sha256-VErtv5+I3BBnfbOQrHFvvLo7GAExXwVmhHNq+84kam8=";
  };

  kanagawa = pkgs.fetchFromGitHub {
    owner = "dangooddd";
    repo = "kanagawa.yazi";
    rev = "d98f0c3e27299f86ee080294df2722c5a634495a";
    hash = "sha256-Z/lyXNCSqX0wvCQd39ZedxOGlhRzQ+M0hqzkBEcpxEE=";
  };

  material-ocean = pkgs.fetchFromGitHub {
    owner = "myamusashi";
    repo = "material-ocean.yazi";
    rev = "b0d8a53e5df7dd9935f8be108c2e6f47c208a75c";
    hash = "sha256-Hc3CmoQYWaIxob7z6bXtrxT/sL/GWxxn8E5fEV4MIKU=";
  };

  fzf = pkgs.fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "fg.yazi";
    rev = "46a5c16f62f415f691319f984b9548249b0edc96";
    hash = "sha256-B6Feg8icshHQYv04Ee/Bo9PPaiDPRyt1HwpirI/yXj8=";
  };
}
