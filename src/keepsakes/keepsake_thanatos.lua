local maxReq = {}
local minReq = {}

if mod.hades_Biomes then
    maxReq = {
        PathTrue = { "GameState", "TextLinesRecord", "ThanatosGift10" },
    }
    minReq = {
        PathTrue = { "GameState", "TextLinesRecord", "ThanatosGift01" },
    }
end

local guid = _PLUGIN.guid
gods.CreateKeepsake({
    characterName = "Thanatos",
    internalKeepsakeName = "PerfectClearDamageBonusKeepsake",

    RarityLevels = {
        Common = { Multiplier = config.Thanatos.a_KeepsakeCommon },
        Rare = { Multiplier = config.Thanatos.b_KeepsakeRare },
        Epic = { Multiplier = config.Thanatos.c_KeepsakeEpic },
        Heroic = { Multiplier = config.Thanatos.d_KeepsakeHeroic },
    },

    ExtractValues = {
        {
            Key = "PerfectClearDamageBonus",
            ExtractAs = guid .. "-TooltipPerfectClearBonus", -- Don't really think i need to prefix this? since you would specifically call it?
            Format = "PercentDelta",
            DecimalPlaces = 1,
        },
        {
            Key = "AccumulatedDamageBonus",
            ExtractAs = "TooltipAccumulatedBonus",
            Format = "PercentDelta",
            DecimalPlaces = 1,
        },
    },

    EquipSound = nil,

    Keepsake = {
        displayName = "Pierced Butterfly",
        description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData." .. guid .. "-TooltipPerfectClearBonus:P} {#Prev}increased damage each time you clear an {$Keywords.EncounterAlt} without taking damage.",
        trayDescription = "Gain {#UpgradeFormat}{$TooltipData.ExtractData." ..
        guid .. "-TooltipPerfectClearBonus:P} {#Prev}bonus damage each time you clear an {$Keywords.EncounterAlt} without taking damage.\n{#StatFormat}Bonus Damage: {#UpgradeFormat}{$TooltipData.ExtractData.TooltipAccumulatedBonus:P}{#Prev}",
        signoffMax = "From {#AwardMaxFormat}Thanatos{#Prev}; you share a {#AwardMaxFormat}Undying Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}With whom should Death belong, if not with Blood, with Life?",
    },

    Icons = {
        iconPath = "GUI\\Screens\\AwardMenu\\Pierced_Butterfly",
        maxIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Thanatos_02",
        maxCornerIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Thanatos",
    },

    customGiftData = {
        customName = "NPC_Thanatos_01",
        maxRequirement = maxReq,
        minRequirement = minReq,
    },

    ExtraFields = {
        PerfectClearDamageBonus = {
            BaseValue = 1.01,
            SourceIsMultiplier = true,
            DecimalPlaces = 3,
        },
        AddOutgoingDamageModifiers = {
            UseTraitValue = "AccumulatedDamageBonus",
        },
        AccumulatedDamageBonus = 1,
        -- ReportedxBonus = 1,
        CustomLabel = {}, -- lifehack
    },
})
