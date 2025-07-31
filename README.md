# Catch Game (LÖVE 2D)

Ein minimalistisches Arcade‑Spiel: Schiebe dein Paddle nach links und rechts, um **herabfallende Kreise** zu fangen, bevor sie den Boden berühren. Entwickelt mit [LÖVE 2D 11.x](https://love2d.org/).

---

## Funktionen

- **Rasantes Gameplay** mit zufällig fallenden Objekten  
- **Shift‑Sprint**: Halte <kbd>Shift</kbd>, um dich schneller zu bewegen  
- Anzeige von Punkten & Leben, „Game Over“-Bildschirm, schnelles Neustarten (<kbd>R</kbd>)  
- Kompakter Lua‑Code (nur *main.lua* + *conf.lua*)

---

## Voraussetzungen

| Tool | Version                  |
| ---- | ------------------------ |
| LÖVE | 11.x                     |
| Lua  | 5.1+ (in LÖVE enthalten) |

---

## Installation & Ausführung

```bash
# Repository klonen oder ZIP herunterladen
cd catch-game-love2d

# Mit LÖVE starten (Punkt = aktueller Ordner)
love .
```

> **Alternative:** Inhalte zippen, Datei in **CatchGame.love** umbenennen und auf die LÖVE‑Exe ziehen.

---

## Steuerung

| Taste                       | Aktion                       |
| --------------------------- | ---------------------------- |
| <kbd>A</kbd> / <kbd>←</kbd> | Nach links bewegen           |
| <kbd>D</kbd> / <kbd>→</kbd> | Nach rechts bewegen          |
| <kbd>Shift</kbd>            | Sprint (schnellere Bewegung) |
| <kbd>R</kbd>                | Nach *Game Over* neu starten |
| <kbd>Esc</kbd>              | Spiel beenden                |

---

## Code‑Struktur

```
📁 Projektordner
 ├─ main.lua      -- Spiellogik & Rendering
 └─ conf.lua      -- (Optional) Fenstertitel & ‑größe
```

- **main.lua** enthält den kompletten Game‑Loop: `love.load`, `love.update`, `love.draw`, `love.keypressed`.  
- **conf.lua** (optional) setzt Fenstertitel & Auflösung – entferne ggf. Kommentar‑Klammern `--[[ ... ]]`, wenn du sie benutzt.

---

## Gameplay anpassen

- **Spawn‑Rate**: `spawnInterval` (Sekunden) in *main.lua* ändern.  
- **Objektgeschwindigkeit**: `o.speed` in `spawnObject()` anpassen.  
- **Sprint‑Faktor**: `player.sprintFactor` (Standard `1.8`) verändern.  
- **Leben & Punkte**: Variablen `lives`, `score` oben in *main.lua*.
