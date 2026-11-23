# HollyTrek

HollyTrek is Super Star Trek with a graphical bridge. It is a port of the BBS
door version 1.1.0 of Super Star Trek
(https://github.com/fstltna/SuperStarTrek) to the Hollywood language.

* Repository: https://github.com/fstltna/HollyTrek
* Website: https://superstartrek.gameplayer.club

The whole C game has been translated. That covers all 37 commands, the
Commanders and the Super-commander, Romulans, Tholians and their webs, planets,
mining and the Galileo, probes, cloaking, capturing, time warps, supernovas,
tractor beams, scoring and the plaque. The original text and rules are kept,
and the game runs in a graphical bridge screen:

* **Short-range scan.** An animated 10x10 sector map with drawn ships, stars,
  starbases, planets, black holes, Tholians and webs. Torpedoes fly across it,
  phaser beams fire, explosions bloom, and the ship glides when it moves. If the
  short-range sensors are damaged, only the sectors next to the ship are shown,
  as in the original.
* **Ship status panel.** Shows the stardate, a condition light (it flashes on
  RED), position, energy and shield bars, torpedo count, warp factor, life
  support, Klingons left, time left and probes.
* **Star chart.** The known galaxy, coloured by Klingons (red), bases (cyan)
  and stars (yellow), with your quadrant highlighted.
* **Devices panel.** Lists each damaged device with its repair time in flight
  and when docked.
* **Command buttons.** One click sends that command.
* **Console.** The original game text, with its colours kept, plus an inline
  command line.

## Ready-made builds

You don't need Hollywood to play. Download the build for your system and keep
`sst.doc` (needed for HELP) and `SST_Logo.txt` in the same folder.

| File                  | System                         |
|-----------------------|--------------------------------|
| `HollyTrek-Win64.exe` | Windows, 64-bit                |
| `HollyTrek-Win32.exe` | Windows, 32-bit                |
| `HollyTrek`           | Linux, 64-bit x86              |
| `HollyTrek-Linux32`   | Linux, 32-bit x86              |
| `HollyTrek-LinuxARM`  | Linux, 64-bit ARM (aarch64)    |
| `HollyTrek-AmigaOS3`  | AmigaOS 3 (68k)                |
| `HollyTrek-AmigaOS4`  | AmigaOS 4 (PowerPC)            |
| `HollyTrek-MorphOS`   | MorphOS                        |
| `HollyTrek-AROS`      | AROS (x86)                     |

On Linux you may need to make the file executable first:
`chmod +x HollyTrek`.

### Snap

On Linux you can also install it from the Snap Store:

    sudo snap install hollytrek

The snap stores saved games and plaques in `~/snap/hollytrek/common`.
The snap is built from `snap/snapcraft.yaml` and packs the prebuilt Linux
binaries in this repository (`HollyTrek` for amd64, `HollyTrek-LinuxARM` for
arm64), so rebuild those before building a new snap.

## Running from source

1. Keep these files in one folder: `sst.hws` (the main script), `io.hws`,
   `gfx.hws`, `setup.hws`, `moving.hws`, `battle.hws`, `events.hws`, `ai.hws`,
   `reports.hws`, `finish.hws`, `planets.hws`, plus `sst.doc` (needed for HELP)
   and `SST_Logo.txt`.
2. Open `sst.hws` in the Hollywood IDE and run it, or run `Hollywood sst.hws`.
3. To build a standalone program, compile it from the IDE or the Hollywood
   command line. Ship `sst.doc` and `SST_Logo.txt` beside the executable.

Uses only core Hollywood commands and its inbuilt `#SANS` and `#MONOSPACE`
fonts; no plugins needed (Hollywood 6.1 or newer).

## Playing

You play the game as in the BBS version: type commands and answer the
prompts. The GUI adds these shortcuts:

* **Buttons** send a command straight away. For example, PHASERS then asks
  "Manual or automatic?".
* **Clicking a sector** on the short-range scan types its coordinates
  ("row col") at the prompt, so `photons 1` followed by a click on a Klingon
  aims a torpedo, and `move automatic` followed by a click sets a course.
* **Clicking a quadrant** on the star chart types its coordinates. Use it with
  `move automatic`, `computer` or `probe`.
* **Return** sends the line. Clicking anywhere in the console does the same.
* **Up and Down** step through your command history. **Esc** clears the line.
* **The mouse wheel, PageUp and PageDown** scroll back through the console.
* When the console fills up, `[CONTINUE?]` appears, as in the original. Press
  any key or click to continue.

Coordinates are written row first, then column, as in the original
(`Sector 3 - 7` is row 3, column 7).

## Changes from the C version

* These bugs in the C source are fixed:
  * A scheduled supernova compared `quadx` against `quady`, so a supernova in
    your own quadrant was almost never detected (events.c).
  * The Super-commander's diagonal move used `ideltax` for the y axis (ai.c).
  * Death-ray repair while docked read past the end of the damage array
    (events.c).
  * `atover()` kept going after "shields up -- it's hopeless" had already ended
    the game (moving.c).
  * A leftover debug `printf("Hit ... energy ...")` in `attack()` was removed.
  * Typo fixed: "manual file only" now reads "manual fire only".
* The command-line options (`-f` "fixed coordinates" and a game typed on the
  command line) are not supported.
* Random numbers come from a built-in Park-Miller generator, so a tournament
  number always produces the same galaxy on every platform. The galaxies differ
  from the ones the C build generates, because that build uses the system
  `rand()`.
* FREEZE saves the game with Hollywood's `WriteTable()`, and loading it back
  uses `ReadTable()`. Saves from the C version cannot be loaded.
* The Commodore Emeritus plaque is written to a text file instead of a
  132-column printer.

## Source layout

| File          | From          | Contents                                              |
|---------------|---------------|-------------------------------------------------------|
| `sst.hws`     | sst.c, sst.h  | constants, game state, command loop, help, main       |
| `io.hws`      | sst.c         | console, scanner, formatting, math, random numbers    |
| `gfx.hws`     | (new)         | screen layout, drawing, buttons, mouse/keys, effects  |
| `setup.hws`   | setup.c       | new game, freeze/thaw, abandon ship, new quadrant     |
| `moving.hws`  | moving.c      | movement, warp, impulse, dock, time warp, probe, call |
| `battle.hws`  | battle.c      | shields, torpedoes, phasers, enemy attacks, capture   |
| `events.hws`  | events.c      | timed events, rest, nova, supernova                   |
| `ai.hws`      | ai.c          | enemy movement, Super-commander, Tholian              |
| `reports.hws` | reports.c     | scans, chart, status, damage report, computer         |
| `finish.hws`  | finish.c      | game endings, score, plaque, self destruct            |
| `planets.hws` | planets.c     | orbit, transporter, mining, shuttle, death ray        |

Game logic functions keep their C names with a `p_` prefix (for example,
`phasers()` is `p_Phasers()`), so each one can be compared side by side with the
original.

## Version

The HollyTrek version is set by `HT_VERSION` near the top of `sst.hws`. It
appears on the title screen and in the opening text.

## License

GPL v3, the same as the original. See `LICENSE`.
