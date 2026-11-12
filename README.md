# labwc-config

Konfigurasi `labwc` (Wayland, *floating window manager*) yang ringan dan siap pakai di Arch Linux minimal.
Tampilan tipis ala `tint2`, tema gelap dengan aksen biru, tanpa *bloatware*.

## Komponen

| Fungsi | Program |
|---|---|
| Compositor | `labwc` |
| Session manager | `uwsm` |
| Panel (workspace, taskbar, jam, tray) | `waybar` |
| Launcher | `fuzzel` |
| Notifikasi dan OSD volume/kecerahan | `mako` |
| Wallpaper | `swaybg` |
| Kunci layar dan idle | `swaylock`, `swayidle` |
| Terminal | `kitty` |
| File manager | `thunar` |
| Clipboard history | `cliphist` + `wl-clipboard` |
| Screenshot | `grim` + `slurp` |
| Polkit | `polkit-gnome` |

## 1. Persiapan setelah install Arch minimal

Pastikan sudah ada user biasa (bukan root) dengan `sudo`, lalu:

```bash
# Jaringan
sudo systemctl enable --now NetworkManager
# Wi-Fi: sambungkan lewat  nmtui

# Waktu dan zona waktu (supaya jam di panel benar)
sudo timedatectl set-timezone Asia/Jakarta
sudo systemctl enable --now systemd-timesyncd
```

Driver GPU (pilih sesuai kartu grafis):

```bash
sudo pacman -S --needed mesa vulkan-intel      # Intel
sudo pacman -S --needed mesa vulkan-radeon     # AMD
sudo pacman -S --needed nvidia-open nvidia-utils  # NVIDIA (perlu tuning tambahan, cek ArchWiki)
```

## 2. Paket

```bash
# Inti
sudo pacman -S --needed labwc uwsm waybar fuzzel swaybg swaylock swayidle mako kitty \
  polkit-gnome xorg-xwayland \
  xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  pipewire pipewire-pulse wireplumber networkmanager network-manager-applet

# Utilitas
sudo pacman -S --needed thunar thunar-volman gvfs gvfs-mtp udisks2 tumbler swayimg \
  grim slurp cliphist wl-clipboard libnotify brightnessctl playerctl wlr-randr \
  pavucontrol xdg-user-dirs mc git

# Font, tema, ikon, Qt
sudo pacman -S --needed ttf-ubuntu-font-family cantarell-fonts noto-fonts noto-fonts-emoji \
  papirus-icon-theme adw-gtk-theme arc-gtk-theme adwaita-icon-theme dconf nwg-look \
  qt6ct qt6-wayland qt5-wayland
```

Waybar harus versi **0.14.0 atau lebih baru** (modul `ext/workspaces`). Arch biasanya sudah memenuhi.

## 3. Pasang config

```bash
git clone https://github.com/heriheriyanto/labwc-config ~/labwc-config
cd ~/labwc-config
./install.sh
xdg-user-dirs-update
```

`install.sh` menyalin isi folder `.config/` ke `~/.config/`. File lama yang berbeda tidak dihapus,
tapi diganti namanya menjadi `*.bak-<waktu>`. (Jangan `git clone` langsung ke `~/.config`: isi repo
berada di dalam folder `.config/`, jadi path-nya akan salah.)

## 4. Menjalankan

Dari TTY:

```bash
uwsm start labwc.desktop
```

Supaya otomatis masuk labwc saat login di TTY1, tambahkan ke `~/.bash_profile`:

```bash
if uwsm check may-start 1; then
    exec uwsm start labwc.desktop
fi
```

Logout: `Super+X` lalu pilih Logout (menjalankan `uwsm stop`). Jangan memakai perintah exit bawaan labwc
saat berjalan di bawah uwsm.

## 5. Keybind

`Super` = tombol Windows.

| Tombol | Fungsi |
|---|---|
| `Super+Enter` | Terminal (kitty) |
| `Super+Space` | Launcher (fuzzel) |
| `Super+E` | File manager (thunar) |
| `Super+V` | Riwayat clipboard |
| `Super+L` | Kunci layar |
| `Super+X` | Menu daya (lock, logout, suspend, reboot, shutdown) |
| `Super+Q` atau `Alt+F4` | Tutup jendela |
| `Super+F` / `Super+M` / `Super+N` | Fullscreen / maximize / minimize |
| `Super+T` | Selalu di atas |
| `Super+panah` | Snap jendela ke tepi layar |
| `Alt+Tab` | Pindah jendela |
| `Super+1..4` | Pindah workspace |
| `Super+Alt+1..4` | Kirim jendela ke workspace |
| `Ctrl+Alt+Kiri/Kanan` | Workspace sebelumnya/berikutnya |
| `Print` | Screenshot layar penuh |
| `Shift+Print` | Screenshot area (disimpan) |
| `Ctrl+Print` | Screenshot area (hanya ke clipboard) |
| Tombol volume, mic, kecerahan, media | Berfungsi, dengan OSD |
| `Super+Alt+R` | Muat ulang config |
| `Alt+drag` kiri / kanan | Pindah / resize jendela |
| Klik kanan desktop | Menu labwc |

Screenshot disimpan di `~/Pictures/Screenshots/`.

## 6. Penyesuaian yang biasanya perlu

- **Refresh rate tinggi:** jalankan `wlr-randr`, lalu aktifkan dan sesuaikan baris `wlr-randr --output ...`
  di `~/.config/labwc/autostart`.
- **Wallpaper:** taruh gambar di `~/Pictures/wallpaper.png`. Kalau tidak ada, dipakai warna polos.
- **Laptop:** modul baterai dan kecerahan di waybar sudah ada. Kalau kecerahan tidak mau berubah,
  tambahkan user ke grup `video`: `sudo usermod -aG video $USER` lalu login ulang.
- **Tidak mau modul tertentu:** hapus namanya dari `modules-right` di `~/.config/waybar/config`.
- **Qt (qt6ct):** jalankan `qt6ct` sekali, pilih style `Fusion` dan palet gelap.
- **Layout keyboard:** ubah `XKB_DEFAULT_LAYOUT` di `~/.config/labwc/environment`.
- **Flatpak** (opsional, butuh paket `flatpak`):
  `flatpak override --user --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtk-4.0:ro`
- Setelah mengubah `rc.xml`: `Super+Alt+R` atau `labwc --reconfigure`. Waybar: `pkill -SIGUSR2 waybar`.

Aplikasi sehari-hari (browser, editor, dll.) belum disertakan, pasang sesuai kebutuhan.

## 7. Kalau ada yang tidak jalan

| Gejala | Cek |
|---|---|
| Panel tidak muncul | Jalankan `waybar -l debug` di terminal, lihat pesan error |
| Workspace kosong di panel | `waybar --version` harus 0.14.0 atau lebih; kalau tetap kosong, hapus modul `ext/workspaces` |
| Launcher tidak terbuka | `fuzzel --check-config` |
| Keybind tidak bereaksi | `labwc --reconfigure`, lihat log: `journalctl --user -b` |
| Tidak ada suara | `wpctl status`, pastikan `pipewire`, `pipewire-pulse`, `wireplumber` terpasang |
| Dialog buka file GTK tidak muncul | `systemctl --user status xdg-desktop-portal`, pastikan `xdg-desktop-portal-gtk` terpasang |
| Ikon jaringan tidak muncul | Pastikan `nm-applet` berjalan dan panel punya modul `tray` |

## 8. Struktur repo

```
.config/
  labwc/        rc.xml, autostart, environment, themerc-override, scripts/
  waybar/       config, style.css
  fuzzel/       fuzzel.ini
  mako/         config
  kitty/        kitty.conf
  swaylock/     config
  gtk-3.0/      settings.ini
  gtk-4.0/      settings.ini
  xdg-desktop-portal/labwc-portals.conf
install.sh
```
