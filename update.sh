#!/usr/bin/env bash

nix flake update
sudo nixos-rebuild build --flake path:/etc/nixos#waltz --keep-going |& nom
sudo nixos-rebuild build --flake path:/etc/nixos#nixos --keep-going |& nom
home-manager build --flake path:/etc/nixos#myamusashi --keep-going |& nom
