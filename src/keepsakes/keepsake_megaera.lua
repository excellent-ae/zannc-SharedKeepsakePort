local maxReq = {}
local minReq = {}

if mod.hades_Biomes then
	maxReq = {
		PathTrue = { "GameState", "TextLinesRecord", "MegaeraGift10" },
	}
	minReq = {
		PathTrue = { "GameState", "TextLinesRecord", "MegaeraGift01" },
	}
end

gods.CreateKeepsake({
	characterName = "Megaera",
	internalKeepsakeName = "LowHealthDamageKeepsake",

	RarityLevels = {
		Common = { Multiplier = config.Megaera.a_KeepsakeCommon },
		Rare = { Multiplier = config.Megaera.b_KeepsakeRare },
		Epic = { Multiplier = config.Megaera.c_KeepsakeEpic },
		Heroic = { Multiplier = config.Megaera.d_KeepsakeHeroic },
	},

	ExtractValues = {
		{
			Key = "ReportedMultiplier",
			ExtractAs = "TooltipBonus",
			Format = "PercentDelta",
		},
	},

	EquipSound = nil,
	-- ProcSound = "/Leftovers/SFX/PositiveTalismanProc_2",

	Keepsake = {
		displayName = "Skull Earring",
		description = "Deal {#AltUpgradeFormat}{$TooltipData.ExtractData.TooltipBonus:P} {#Prev}damage while at {#BoldFormatGraft}35%{#Prev}{!Icons.Health} or less.",
		signoffMax = "From {#AwardMaxFormat}Megaera{#Prev}; you share an {#AwardMaxFormat}Intense Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}Your deaths at one another's hands... all your pleasure, all your pain, united.",
	},

	Icons = {
		iconPath = "GUI\\Screens\\AwardMenu\\Skull_Earring",
		maxIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Meg_02",
		maxCornerIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Meg",
	},

	customGiftData = {
		customName = "NPC_FurySister_01",
		maxRequirement = maxReq,
		minRequirement = minReq,
	},

	ExtraFields = {
		LowHealthThresholdText = {
			-- Display variable only, to change the data value change the value below under "LowHealthThreshold"
			PercentThreshold = 0.35,
			-- Text = guid .. "-Hint_LowHealthDamageTrait",
		},
		AddOutgoingDamageModifiers = {
			HighHealthSourceMultiplierData = {
				Threshold = 0.35,
				ThresholdMultiplier = 0,
				Multiplier = {
					BaseValue = 1.2,
					SourceIsMultiplier = true,
				},
				ReportValues = {
					ReportedMultiplier = "Multiplier",
				},
			},
		},
	},
})
