#!/usr/bin/env zsh

# Vacuum journals
sudo journalctl --vacuum-size=500M && sudo journalctl --vacuum-time=7d

# Remove all uninstalled packages
sudo paccache -rvuk0

# Remove old installed packages, leave 3
sudo paccache -rvk3

# Clean yay cache
yay -Sc -a

# Clean pamac build cache
command -v pamac >/dev/null 2>&1 && pamac clean -bv

# Clean language & package caches
command -v go >/dev/null 2>&1 && go clean -cache -modcache -testcache -fuzzcache
command -v pnpm >/dev/null 2>&1 && { pnpm cache prune --yes 2>/dev/null || true; pnpm store prune 2>/dev/null || true; }
command -v npm >/dev/null 2>&1 && npm cache clean --force
command -v yarn >/dev/null 2>&1 && yarn cache clean
command -v dart >/dev/null 2>&1 && dart pub cache clean -f
command -v cargo-cache >/dev/null 2>&1 && cargo cache --autoclean
command -v dotnet >/dev/null 2>&1 && dotnet nuget locals all --clear

# Clean expendable application & build caches (leaving Dolphin, thumbnails, Vivaldi, Zen intact)
rm -rf ~/.cache/{electron,electron-builder,go-build,node-gyp,pip,yarn,ms-playwright,ms-playwright-go,rod,spotify,tracker3,kioexec} 2>/dev/null || true

# Clean VS Code C++ workspace indexing database bloat
rm -rf ~/.config/Code/User/workspaceStorage/*/ms-vscode.cpptools 2>/dev/null || true

# Find files not owned by any package
sudo lostfiles
