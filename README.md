# MonkFighter2

Standalone World of Warcraft addon for Windwalker Monk that:

- plays custom sound effects for selected abilities
- shows a movable combo counter HUD
- tracks Combo Strikes-eligible abilities separately from sound support
- persists combo state across combat with an optional HUD hide delay

## Install

Copy the `MonkFighter2/` folder into your WoW addons directory:

`World of Warcraft/_retail_/Interface/AddOns/MonkFighter2`

Then reload the UI or restart the game.

## Features

- Street Fighter-inspired sound pack with per-ability remapping
- separate support for talent variants and replacement abilities
- Killer Instinct `COMBO BREAKER!` sound on repeated combo-tracked casts
- movable combo HUD with saved position
- optional combo persistence outside combat
- configurable out-of-combat HUD hide delay

## Commands

- `/mf2`
  Opens the addon options panel.
- `/mf2 unlock`
  Unlocks the combo HUD for dragging.
- `/mf2 lock`
  Locks the combo HUD in place.
- `/mf2 reset`
  Resets the combo HUD position.

## Notes

- The addon package is the `MonkFighter2/` directory in this repo.
- Sound support and Combo Strikes tracking are maintained separately on purpose.
- Some older Windwalker-era spells remain supported for sound mapping even if they are not part of the current Combo Strikes aura family.
