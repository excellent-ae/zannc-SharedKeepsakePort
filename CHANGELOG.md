# Changelog

## [Unreleased]

- Fixed: "Shattered Shackle" description text does not include Omega moves, even though the bonus also applies to them.

## [1.4.1] - 2026-05-15

- Fixed: The displayed damage bonus value for Thanatos' keepsake resets on level up if `KeepsakePort` is not installed.

## [1.4.0] - 2026-04-23

- Moved Megaera's keepsake from `KeepsakePort` to `SharedKeepsakePort`.
- Added `Achilles` to `SharedKeepsakePort`.
- Fix: Possible issue resolved where keepsakes can be duplicated when loaded due to movement between `KeepsakePort` and `SharedKeepsakePort` due to configs.

## [1.2.0] - 2026-02-21

- Added Orpheus' Keepsake.

## [1.1.8] - 2026-01-26

- DEV: Change PLUGIN to \_PLUGIN

## [1.1.7] - 2026-01-21

- Fix: Forgot table insert that fixes reset to 0% fix on advancing Thanatos and Hermes keepsakes.

## [1.1.6] - 2026-01-21

- Fixed crashes with Hermes and Thanatos' keepsakes when you clear a room due to a nil plugin reference. Closes #10
- Fixed issue where Hermes & Thanatos would lose their respective bonuses if ranked up midrun. Closes #11
- QOL: Changed Thanatos' and Hermes' keepsake descriptions to display the bonus gained per room completed. Closes #12

## [1.1.5] - 2026-01-02

- Fix issue where any healing was shown as +0 on interaction instead of the actual value.
- Fix issue where if you were right on the threshold for Meg's keepsake, it still wouldn't proc.

## [1.1.4] - 2026-01-01

- Fix "Keepsake Received" popup missing when receiving keepsakes in Zagreus' Journey.

## [1.1.3] - 2025-12-23

- Fix nil thrown error when completing rooms with Thanatos' Keepsake.

## [1.1.2] - 2025-12-23

- Fix nil thrown error when going into non combat rooms.

## [1.1.1] - 2025-12-23

- Fix nil thrown error when KeepsakePort isn't installed.

## [1.1.0] - 2025-12-23

- Added Megaera's Keepsake.
- Add % increase to Hermes' Keepsake.
- Remove extra "}" in multiple descriptions.
- Added decimal places for invulnerability duration in Patroclus' keepsake.
- DEV: Port all of `KeepsakePort's` code over to `SharedKeepsakePort`.
- DEV: Code Rewrites.
- DEV: Remove Bonus Dodge/Speed when unequipping Hermes' Keepsake.
- DEV: Move from reload, guid-prefixed functions.
- DEV: Fix Min/Max Requirements.
- DEV: Hopefully fix Hermes for good with encounter clearing.

## [1.0.8] - 2025-12-08

- Fix crash with grisly gain.

## [1.0.7] - 2025-12-07

## [1.0.6] - 2025-11-29

- Add % to Thanatos' Keepsake

## [1.0.5] - 2025-11-29

- Missed Patroclus Keepsake name.

## [1.0.4] - 2025-11-27

- Update to match `Zagreus_Journey` naming

## [1.0.3] - 2025-11-08

- Moved Thanatos to this mod for Hades Biomes.
- Reduced Package Size.
- Added Clear Effects for Thanatos.

## [1.0.2] - 2025-10-24

- Fix MaxRequirement for Euyridce and Patroclus for Hades_Biomes.
- Disable Patroclus Keepsake UI when an encounter ends.

## [1.0.1] - 2025-10-11

- Fix Icon.

## [1.0.0] - 2025-10-11

- Initial Release.

[unreleased]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.4.1...HEAD
[1.4.1]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.4.0...1.4.1
[1.4.0]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.2.0...1.4.0
[1.2.0]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.8...1.2.0
[1.1.8]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.7...1.1.8
[1.1.7]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.6...1.1.7
[1.1.6]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.5...1.1.6
[1.1.5]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.4...1.1.5
[1.1.4]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.3...1.1.4
[1.1.3]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.8...1.1.0
[1.0.8]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.7...1.0.8
[1.0.7]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.6...1.0.7
[1.0.6]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.5...1.0.6
[1.0.5]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.4...1.0.5
[1.0.4]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.3...1.0.4
[1.0.3]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/excellent-ae/zannc-SharedKeepsakePort/compare/d9fa1801d87919a6b01dbf9a7293feddad74d5a2...1.0.0
