local maxReq = {}
local minReq = {}

if mod.hades_Biomes then
    maxReq = {
        PathTrue = { "GameState", "TextLinesRecord", "BecameCloseWithDusa01" },
    }
    minReq = {
        PathTrue = { "GameState", "TextLinesRecord", "DusaGift01" },
    }
end

gods.CreateKeepsake({
    characterName = "Dusa",
    internalKeepsakeName = "LifeOnUrnKeepsake",

    RarityLevels = {
        Common = { Multiplier = config.Dusa.a_KeepsakeCommon },
        Rare = { Multiplier = config.Dusa.b_KeepsakeRare },
        Epic = { Multiplier = config.Dusa.c_KeepsakeEpic },
        Heroic = { Multiplier = config.Dusa.d_KeepsakeHeroic },
    },

    ExtractValues = {
        {
            Key = "ReportedDropRate",
            ExtractAs = "TooltipDropChance",
            Format = "Percent",
        },
    },

    EquipSound = nil,

    Keepsake = {
        displayName = "Harpy Feather Duster",
        description = "Broken urns have a {#AltUpgradeFormat}{$TooltipData.ExtractData.TooltipDropChance}% {#Prev}chance to contain {!Icons.HealthRestore} items.",
        signoffMax = "From {#AwardMaxFormat}Dusa{#Prev}; you share an {#AwardMaxFormat}Immaculate Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}She lifts you up without effort. You give her courage to fly.",
    },

    Icons = {
        iconPath = "GUI\\Screens\\AwardMenu\\Harpy_Feather_Duster",
        maxIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Dusa_02",
        maxCornerIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Dusa",
    },

    customGiftData = {
        customName = "ModsNikkelMHadesBiomes_NPC_Dusa_01",
        maxRequirement = maxReq,
        minRequirement = minReq,
    },

    ExtraFields = {
        DropOnKill = {
            Chance = { BaseValue = 0.03 },
            DropCap = 1,
            Name = "HealDropMinor",
            ValidEnemies = { "Breakable" },
            ReportValues = {
                ReportedDropRate = "Chance",
            },
        },
    },
})
