# Misalnya, di file 'backend-package.nix' di direktori yang sama dengan configuration.nix
{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "nix-build-monitor-backend-app";
  version = "1.0";

  # Ini akan menyalin seluruh direktori backend Anda ke Nix store
  # Ganti dengan path ABSOLUT ke direktori *sumber* backend Anda
  src = /var/www/nix-cache-backend; # Ganti dengan path sebenarnya!

  # Build phase: instal dependencies dan kompilasi TypeScript
  buildPhase = ''
    export HOME=$(mktemp -d) # Pastikan npm/yarn bisa menulis ke home sementara
    npm install --prefix $src
    npm run build --prefix $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/dist $out/
    cp $src/package.json $out/
    cp -r $src/node_modules $out/
    cat > $out/bin/nix-monitor-backend-start <<EOF
    #!/bin/sh
    # Pastikan ripgrep dan coreutils ada di PATH
    export PATH=${pkgs.ripgrep}/bin:${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:$PATH
    exec ${pkgs.nodejs_22}/bin/node $out/dist/index.js
    EOF
    chmod +x $out/bin/nix-monitor-backend-start
  '';

  # Dependensi yang dibutuhkan selama build (node, npm, typescript)
  buildInputs = with pkgs; [nodejs_22 typescript];

  # Dependensi yang dibutuhkan saat runtime (node, ripgrep, coreutils, grep)
  nativeBuildInputs = [pkgs.makeWrapper]; # untuk membuat wrapper
  runtimeDependencies = with pkgs; [nodejs_22 ripgrep coreutils gnugrep];
}
