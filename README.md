# labwc-config
Config Labwc for my personal computer

# Labwc Minimalist Dotfiles

Konfigurasi ringan (*floating window manager*) berbasis Wayland menggunakan `labwc`, dirancang bersih tanpa *bloatware* ("no bala"), cepat untuk layar ber-refresh rate tinggi, serta mengadopsi estetika tipis ala `tint2`.

## Komponen Utama
* **Compositor:** `labwc` (DNA Openbox di atas Wayland)
* **Panel:** `waybar` (Didesain tipis & elegan dengan font Ubuntu/Cantarell)
* **Launcher:** `fuzzel` (Cepat, ringan, native Wayland)
* **Wallpaper:** `swaybg`
* **Terminal:** `kitty`

## Kebutuhan Paket (Arch Linux)
```bash
sudo pacman -S labwc waybar fuzzel swaybg pipewire pipewire-pulse wireplumber networkmanager kitty mc ttf-ubuntu-font-family cantarell-fonts
```bash
sudo pacman -S thunar thunar-volman swayimg grim slurp cliphist pavucontrol
