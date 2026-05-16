local maxReq = {}
local minReq = {}

if mod.hades_Biomes then
	maxReq = {
		PathTrue = { "GameState", "TextLinesRecord", "SisyphusGift09_A" },
	}
	minReq = {
		PathTrue = { "GameState", "TextLinesRecord", "SisyphusGift01" },
	}
end

gods.CreateKeepsake({
	characterName = "Sisyphus",
	internalKeepsakeName = "SisyphusVanillaKeepsake",

	RarityLevels = {
		Common = { Multiplier = config.Sisyphus.a_KeepsakeCommon },
		Rare = { Multiplier = config.Sisyphus.b_KeepsakeRare },
		Epic = { Multiplier = config.Sisyphus.c_KeepsakeEpic },
		Heroic = { Multiplier = config.Sisyphus.d_KeepsakeHeroic },
	},

	ExtractValues = {
		{
			Key = "ReportedWeaponMultiplier",
			ExtractAs = "TooltipBonus",
			Format = "PercentDelta",
			SkipAutoExtract = true,
		},
	},

	EquipSound = nil,

	Keepsake = {
		displayName = "Shattered Shackle",
		description = "Your {$Keywords.AttackSet}, {$Keywords.SpecialSet} and {$Keywords.CastSet} each deal {#UpgradeFormat}{$TooltipData.ExtractData.TooltipBonus:P} {#Prev}damage while not empowered by a {$Keywords.GodBoon}.",
		trayDescription = "Your {$Keywords.AttackSet}, {$Keywords.SpecialSet} and {$Keywords.CastSet} each deal {#UpgradeFormat}{$TooltipData.ExtractData.TooltipBonus:P} {#Prev}damage while not empowered by a {$Keywords.GodBoon}.",
		signoffMax = "From {#AwardMaxFormat}Sisyphus{#Prev}; you share a {#AwardMaxFormat}Rock-Solid Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}If he can hoist a boulder on his own, he knows he can be of some support.",
	},

	Icons = {
		iconPath = "GUI\\Screens\\AwardMenu\\Shattered_Shackle",
		maxIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Sisyphus_02",
		maxCornerIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Sisyphus",
	},

	customGiftData = {
		customName = "NPC_Sisyphus_01",
		maxRequirement = maxReq,
		minRequirement = minReq,
	},

	ExtraFields = {
		AddOutgoingDamageModifiers = {
			EmptySlotMultiplier = { BaseValue = 1.5, SourceIsMultiplier = true },
			EmptySlotValidData = {
				Melee = WeaponSets.HeroNonExWeapons,
				Secondary = WeaponSets.HeroSecondaryWeapons,
				Ranged = WeaponSets.HeroNonPhysicalWeapons,
			},
			ReportValues = { ReportedWeaponMultiplier = "EmptySlotMultiplier" },
		},
	},
})
