# My Neovim Configuration

This is a flake that makes use of the nixvim library to build a neovim
configuration using primarily nix expressions.

## Usage
This can either be used directly by running the flake:
`nix run github:hcssmith/nix-neovim` 
or this can be inculded in a flake as part of an overlay this can be consumed as
`inputs.nix-neovim.overlays.default` which overwrites the nix package.
