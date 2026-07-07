#!/bin/bash
# ────────────────────────────────────────────────────────────────
#  Genera automaticamente GALLERIA_DONNA.json e GALLERIA_UOMO.json
#  leggendo i file immagine presenti nelle rispettive cartelle.
#
#  Come usarlo (Mac / Linux):
#  1. Apri il Terminale
#  2. Trascina questa cartella nel Terminale (oppure scrivi il percorso)
#  3. Esegui:   bash genera_galleria.sh
# ────────────────────────────────────────────────────────────────

cd "$(dirname "$0")"

genera() {
  folder="$1"
  output="$2"
  entries=""
  for f in "$folder"/*; do
    [ -f "$f" ] || continue
    name="$(basename "$f")"
    # salta i file nascosti e .gitkeep
    case "$name" in .*|.gitkeep) continue ;; esac
    # accetta solo immagini comuni
    case "${name##*.}" in
      jpg|jpeg|png|webp|gif|JPG|JPEG|PNG|WEBP|GIF|avif|AVIF) ;;
      *) continue ;;
    esac
    if [ -z "$entries" ]; then
      entries="\"$name\""
    else
      entries="$entries, \"$name\""
    fi
  done
  printf '[%s]\n' "$entries" > "$output"
  echo "  ✓ $output aggiornato"
}

echo "Scansione cartelle..."
genera "IMMAGINI_DONNA" "GALLERIA_DONNA.json"
genera "IMMAGINI_UOMO"  "GALLERIA_UOMO.json"
echo "Fatto! Ricarica il sito nel browser."
