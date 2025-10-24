---@meta _
---@diagnostic disable: lowercase-global
-- Absolute Path links to plugins_data folder - mod folder, then package name - which MUST contain mod author name for uniqueness
local package = rom.path.combine(_PLUGIN.plugins_data_mod_folder_path, _PLUGIN.guid)
-- Example Output of Package Path:
-- C:\Program Files (x86)\Steam\steamapps\common\Hades II\Ship\ReturnOfModding\plugins_data\zannc-KeepsakePort\zannc-KeepsakePort
modutil.mod.Path.Wrap("SetupMap", function(base)
	game.LoadPackages({ Name = package })
	base()
end)

modutil.mod.Path.Wrap("TraitUIActivateTraits", function(base, args)
	TraitUIActivateTraits_Wrap(base, args)
	base(args)
end)

modutil.mod.Path.Wrap("EndEncounterEffects", function(base, currentRun, currentRoom, currentEncounter)
	EndEncounterEffects_wrap(base, currentRun, currentRoom, currentEncounter)
	base(currentRun, currentRoom, currentEncounter)
end)
