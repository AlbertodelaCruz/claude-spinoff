# spinoff — skill de Claude Code

Cuando en mitad de una sesión de Claude Code surge otra tarea, `/spinoff` la separa en una **nueva pestaña de Ptyxis** con una sesión de Claude independiente que arranca con un resumen dirigido solo de esa tarea. Así no se mezclan contextos.

## Qué hace

1. Identifica la tarea a separar (del argumento o de lo último hablado).
2. Te pregunta, con valores por defecto:
   - **Directorio de trabajo**: el de la sesión actual si no indicas otro.
   - **Nombre de la sesión**: uno sugerido a partir de la tarea.
   - **Remote control**: sí / no.
3. Escribe un brief en `/tmp/claude-spinoff-<nombre>-<timestamp>.md` (objetivo, hallazgos, ficheros, decisiones, siguientes pasos).
4. Abre una pestaña nueva con `claude -n <nombre> [--remote-control <nombre>]` y le pasa el brief como primer mensaje.
5. Vuelve a la tarea original.

## Uso

```
/spinoff
/spinoff investigar por qué falla el build de docs
```

## Instalación

```sh
git clone https://github.com/AlbertodelaCruz/claude-spinoff.git ~/.claude/skills/spinoff
```

Claude Code detecta la skill automáticamente (no hace falta reiniciar).

Opcional, para que no pida permiso al lanzar el script, añade en `~/.claude/settings.json`:

```json
{ "permissions": { "allow": ["Bash(~/.claude/skills/spinoff/launch.sh:*)"] } }
```

## Requisitos

- Linux con [Ptyxis](https://gitlab.gnome.org/chergert/ptyxis) como terminal (usa `ptyxis --tab`).
- `zsh`: la pestaña ejecuta `claude` vía `zsh -ic` para cargar `~/.zshrc` (PATH con `~/.local/bin`). Al salir de Claude la pestaña queda en una shell.
- Claude Code con soporte de `-n/--name` y `--remote-control`.

## Ficheros

| Fichero | Función |
|---|---|
| `SKILL.md` | Instrucciones que sigue Claude al invocar `/spinoff`. |
| `launch.sh` | `launch.sh <dir> <nombre> <0\|1> <brief>`: valida y abre la pestaña. |

Para otro terminal, adapta la línea `ptyxis --tab ...` de `launch.sh` (p. ej. `gnome-terminal --tab --working-directory=... --`, `kitty @ launch --type=tab --cwd=...`, `tmux new-window -c ...`).

## Licencia

[MIT](LICENSE)
