#!/usr/bin/env bash

if [[ ! -d "$HOME/.icons" ]]; then
    mkdir -p "$HOME/.icons"
fi

if [[ ! -d "$HOME/.themes" ]]; then
    mkdir -p "$HOME/.themes"
fi

if [[ ! -d "$HOME/.local/share/icons" ]]; then
    mkdir -p "$HOME/.local/share/icons"
fi

if [[ ! -d "$HOME/.local/share/themes" ]]; then
    mkdir -p "$HOME/.local/share/themes"
fi

## rebuild for now because we flakes experimental shit issue
sudo grep -q 'nix.settings' /etc/nixos/configuration.nix || \
sudo sed -i '$ i\
nix.settings = {\
    trusted-users = [ "root" "myamusashi" ];\
    experimental-features = [ "nix-command" "flakes" ];\
};' /etc/nixos/configuration.nix

sudo nixos-rebuild switch

## Copy hardware-configuration 
cp -f "/etc/nixos/hardware-configuration.nix" "$HOME/.dots/system/config/modules"

## Install cachix
nix-env -iA cachix -f "https://cachix.org/api/v1/install"

## flake update
nix --extra-experimental-features "nix-command flakes" flake update

## Install nixos unstable and home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update
sudo nixos-rebuild switch --flake "$HOME/.dots" --keep-going --upgrade

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch --flake "$HOME/.dots" --keep-going
