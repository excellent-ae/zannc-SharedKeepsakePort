---@meta _
---@diagnostic disable

local mods = rom.mods

---@module 'LuaENVY-ENVY-auto'
mods["LuaENVY-ENVY"].auto()

rom = rom
_PLUGIN = _PLUGIN

---@module 'SGG_Modding-Hades2GameDef-Globals'
game = rom.game

---@module 'SGG_Modding-SJSON'
sjson = mods["SGG_Modding-SJSON"]

---@module 'SGG_Modding-ModUtil'
modutil = mods["SGG_Modding-ModUtil"]

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]

---@module 'SGG_Modding-ReLoad'
reload = mods["SGG_Modding-ReLoad"]

---@module 'zannc-GodsAPI-auto'
gods = mods["zannc-GodsAPI"].auto()

---@module 'zannc-SharedKeepsakePort-config'
config = chalk.auto("config.lua")
public.config = config

local function on_ready()
    import("ready.lua")

    local keepsakePort = mods["zannc-KeepsakePort"]
    mod.keepsakePortConfig = nil

    if keepsakePort then
        mod.keepsakePortConfig = keepsakePort.config

        local keepsakePort_names = {
            --*KeepsakePort
            "Hermes",
            "Persephone",
            -- "Chaos",
            -- "Nyx",
        }

        for _, name in ipairs(keepsakePort_names) do
            if mod.keepsakePortConfig and mod.keepsakePortConfig[name] and mod.keepsakePortConfig[name].Enabled then
                import("keepsakes/keepsake_" .. string.lower(name) .. ".lua")
            end
        end

        table.insert(game.PersistentKeepsakeKeys, "AccumulatedDodgeBonus")
    end

    local sharedPort_names = {
        --*SharedKeepsakePort
        "Sisyphus",
        "Eurydice",
        "Patroclus",
        "Thanatos",
        "Orpheus",
        "Megaera",
        "Achilles",
        "Dusa",
    }

    for _, name in ipairs(sharedPort_names) do
        if config[name] and config[name].Enabled then
            import("keepsakes/keepsake_" .. string.lower(name) .. ".lua")
        end
    end

    table.insert(game.PersistentKeepsakeKeys, "AccumulatedDamageBonus")
end

local function on_reload()
    -- import("reload.lua")
end

local loader = reload.auto_single()
modutil.once_loaded.game(function()
    if config.enabled == false then
        return
    end
    import_as_fallback(rom.game)
    mod = modutil.mod.Mod.Register(_PLUGIN.guid)

    mod.TraitTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/TraitText.en.sjson")
    mod.HelpTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/HelpText.en.sjson")
    mod.GUIBoonsVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Boons_VFX.sjson")
    mod.GUIHUDVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_HUD_VFX.sjson")

    mod.Order = {
        "Id",
        "InheritFrom",
        "DisplayName",
        "Description",
        "Name",
        "FilePath",
        "EndFrame",
        "NumFrames",
        "PlaySpeed",
        "StartFrame",
        "Scale",
        "OffsetY",
        "OffsetX",
        "PlayBackwards",
        "AddColor",
        "FlipHorizontal",
        "Red",
        "Green",
        "Blue",
        "VisualFxIntervalMin",
        "VisualFxIntervalMax",
        "VisualFx",
        "Loop",
        "ChainTo",
    }

    mod.hades_Biomes = mods["NikkelM-Zagreus_Journey"]

    loader.load(on_ready, on_reload)

    local than_hermes_helptext_sjson = sjson.to_object({
        Id = _PLUGIN.guid .. "-Hint_ReportedxBonus",
        DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.Amount:P}",
    }, mod.Order)
    local meg_helptext_sjson = sjson.to_object({
        Id = _PLUGIN.guid .. "-Hint_LowHealthDamageTrait",
        DisplayName = "Skull Earring!",
    }, mod.Order)

    sjson.hook(mod.HelpTextFile, function(data)
        table.insert(data.Texts, than_hermes_helptext_sjson)
        table.insert(data.Texts, meg_helptext_sjson)
    end)
end)
