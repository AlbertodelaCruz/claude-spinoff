#!/usr/bin/env bash
# Uso: launch.sh <dir> <nombre> <rc:0|1> <brief-file>
set -euo pipefail
dir="${1/#\~/$HOME}"; name="$2"; rc="$3"; brief="$4"
[[ -d "$dir" ]] || { echo "No existe el directorio: $dir" >&2; exit 1; }
[[ -f "$brief" ]] || { echo "No existe el brief: $brief" >&2; exit 1; }
args=(claude -n "$name")
[[ "$rc" == 1 ]] && args+=(--remote-control "$name")
prompt="Esta sesión continúa una tarea derivada de otra sesión de Claude. Lee el brief y ponte con ello (el original está en $brief):

$(cat "$brief")"
# Run through an interactive zsh so ~/.zshrc loads (PATH with ~/.local/bin, etc.)
# and keep the tab open with a shell when claude exits.
ptyxis --tab -d "$dir" -T "$name" -- zsh -ic '"$@"; exec zsh' zsh "${args[@]}" "$prompt" >/dev/null 2>&1 &
disown
echo "Lanzada '$name' en $dir (remote-control: $([[ $rc == 1 ]] && echo sí || echo no))"
