local maxReq = {}
local minReq = {}

if mod.hades_Biomes then
    maxReq = {
        PathTrue = { "GameState", "TextLinesRecord", "AchillesGift09_A" },
    }
    minReq = {
        PathTrue = { "GameState", "TextLinesRecord", "AchillesGift01" },
    }
end

gods.CreateKeepsake({
    characterName = "Achilles",
    internalKeepsakeName = "DirectionalArmorKeepsake",

    RarityLevels = {
        Common = { Multiplier = config.Achilles.a_KeepsakeCommon },
        Rare = { Multiplier = config.Achilles.b_KeepsakeRare },
        Epic = { Multiplier = config.Achilles.c_KeepsakeEpic },
        Heroic = { Multiplier = config.Achilles.d_KeepsakeHeroic },
    },

    ExtractValues = {
        {
            Key = "HitArmorMultiplierKey",
            ExtractAs = "TooltipDefense",
            Format = "NegativePercentDelta",
        },
        {
            Key = "HitVulnerabilityMultiplierKey",
            ExtractAs = "TooltipVulnerability",
            Format = "PercentDelta",
        },
    },

    EquipSound = nil,

    Keepsake = {
        displayName = "Myrmidon Bracer",
        description = "Take {#AltUpgradeFormat}-{$TooltipData.ExtractData.TooltipDefense}% {#Prev}damage from the front, but take {#AltPenaltyFormat}{$TooltipData.ExtractData.TooltipVulnerability:P} {#Prev}from the back.",
        signoffMax = "From {#AwardMaxFormat}Achilles{#Prev}; you share a {#AwardMaxFormat}Sonorous Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}Inspiration comes from unlikely places. Friendship comes in unlikely forms.",
    },
    -- Can't use :P in TooltipDefense because it assumes it's a +% not -%

    Icons = {
        iconPath = "GUI\\Screens\\AwardMenu\\Myrmidon_Bracer",
        maxIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Achilles_02",
        maxCornerIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Achilles",
    },

    customGiftData = {
        customName = "ModsNikkelMHadesBiomes_NPC_Achilles_01",
        maxRequirement = maxReq,
        minRequirement = minReq,
    },

    ExtraFields = {
        AddIncomingDamageModifiers =
        {
            HitVulnerabilityMultiplier = 1.1,
            IncludeObstacleDamage = true,
            HitArmorMultiplier =
            {
                BaseValue = 0.9,
                SourceIsMultiplier = true,
            },
            ReportValues = {
                HitArmorMultiplierKey = "HitArmorMultiplier",
                HitVulnerabilityMultiplierKey = "HitVulnerabilityMultiplier"
            },
        },
        PropertyChanges =
        {
            {
                LifeProperty = "ArmorCoverage",
                ChangeValue = math.rad(200),
                ChangeType = "Absolute",
                DataValue = false,
            },
        },
    },
})
