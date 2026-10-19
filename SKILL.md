---
name: spinoff
description: Separa una tarea secundaria que ha surgido en esta sesión y la abre en una nueva pestaña de Ptyxis con otra sesión de Claude que arranca con un resumen dirigido. Úsalo cuando el usuario pida /spinoff o quiera "llevar esto a otra sesión/pestaña". Argumento opcional = descripción de la tarea.
---

# Spinoff: llevar una tarea a otra sesión

Argumentos: `$ARGUMENTS` (descripción opcional de la tarea a separar).

1. **Identifica la tarea.** Usa `$ARGUMENTS`; si está vacío, toma la tarea secundaria más reciente de la conversación. Si hay ambigüedad real, pregunta.
2. **Propón un nombre** corto en kebab-case derivado de la tarea (p. ej. `fix-login-timeout`).
3. **Pregunta con una sola `AskUserQuestion`** (3 preguntas, la primera opción es el valor por defecto):
   - **Directorio** — opción 1: `Mismo que esta sesión (<cwd actual>)`; el usuario puede escribir otra ruta con "Other".
   - **Nombre** — opción 1: `<nombre propuesto>`; "Other" para otro.
   - **Remote control** — `No` / `Sí`.
4. **Escribe el brief** en `/tmp/claude-spinoff-<nombre>-<YYYYmmdd-HHMMSS>.md`, solo con lo relevante para la tarea nueva (nada de la tarea principal):
   - Objetivo y criterio de "hecho".
   - Origen: directorio de la sesión padre y cómo surgió.
   - Lo que ya se sabe: hallazgos, errores exactos, hipótesis descartadas.
   - Ficheros, comandos y URLs relevantes (rutas absolutas).
   - Decisiones ya tomadas y restricciones.
   - Siguientes pasos sugeridos.
5. **Lanza**: `~/.claude/skills/spinoff/launch.sh "<dir>" "<nombre>" <0|1> "<brief>"`.
6. Confirma en una línea (nombre, directorio, remote-control) y **vuelve a la tarea original** sin trabajar en la separada.
