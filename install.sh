#!/bin/sh
# Pasang config ke ~/.config.
# File lama yang berbeda tidak dihapus: diganti namanya menjadi <nama>.bak-<waktu>.
# Pemakaian: ./install.sh

set -eu

SRC="$(cd "$(dirname "$0")" && pwd)/.config"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"

if [ ! -d "$SRC" ]; then
    echo "Folder $SRC tidak ditemukan. Jalankan script ini dari dalam repo." >&2
    exit 1
fi

find "$SRC" -type f | while IFS= read -r f; do
    rel="${f#"$SRC"/}"
    target="$DEST/$rel"
    mkdir -p "$(dirname "$target")"
    if [ -e "$target" ] && ! cmp -s "$f" "$target"; then
        mv "$target" "$target.bak-$STAMP"
        echo "backup : $target.bak-$STAMP"
    fi
    cp -p "$f" "$target"
    echo "pasang : $target"
done

chmod +x "$DEST"/labwc/scripts/lw-*
mkdir -p "$HOME/Pictures/Screenshots"

echo
echo "Selesai. Jalankan dari TTY dengan:  uwsm start labwc.desktop"
