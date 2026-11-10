# labwc-config
Config Labwc for my personal computer

# Labwc Minimalist Dotfiles

Konfigurasi ringan (*floating window manager*) berbasis Wayland menggunakan `labwc`, dirancang bersih tanpa *bloatware* ("no bala"), cepat untuk layar ber-refresh rate tinggi, serta mengadopsi estetika tipis ala `tint2`.

## Komponen Utama
* **Compositor:** `labwc` (DNA Openbox di atas Wayland)
* **Session Manager:** `uwsm` (session manager untuk Wayland)
* **Panel:** `waybar` (Didesain tipis & elegan dengan font Ubuntu/Cantarell)
* **Launcher:** `fuzzel` (Cepat, ringan, native Wayland)
* **Wallpaper:** `swaybg`
* **Terminal:** `kitty`

## Kebutuhan Paket (Arch Linux)
### 1. Paket utama
```bash
sudo pacman -S labwc uwsm waybar fuzzel swaybg pipewire pipewire-pulse wireplumber networkmanager kitty mc ttf-ubuntu-font-family cantarell-fonts
```
```bash
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-wlr
```
### 2. Additional Package
```bash
sudo pacman -S thunar thunar-volman swayimg grim slurp cliphist wl-clipboard pavucontrol
```
### Memastikan service network-manager 
```bash
sudo systemctl enable --now NetworkManager
```
## Running dari TTY
```bash
uwsm start labwc
```
## Git-clone
```bash
git clone https://github.com/heriheriyanto/labwc-config ~/.config
```
```bash
git clone https://github.com/heriheriyanto/labwc-themes ~/.local/share/themes
```
