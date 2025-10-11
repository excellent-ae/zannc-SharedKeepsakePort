local mods = rom.mods
local hades_Biomes = mods["NikkelM-Hades_Biomes"]

function CreateKeepsake_Sisyphus()
	-- Creating Keepsake Order
	table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "SisyphusVanillaKeepsake")

	-- Creating Gift Data
	if hades_Biomes then
		game.GiftData.NPC_Sisyphus_01 = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = {
				{
					PathTrue = { "GameState", "TextLinesRecord", "SisyphusGift09_A" },
				},
			},
			MaxedIcon = "Keepsake_Sisyphus_Corner",
			MaxedSticker = "Keepsake_Sisyphus",
			[1] = {
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", "SisyphusGift01" },
					},
				},
				Gift = "SisyphusVanillaKeepsake",
			},
		}
	else
		game.GiftData.NPC_Sisyphus_01 = {
			[1] = {
				Gift = "SisyphusVanillaKeepsake",
			},
			InheritFrom = { "DefaultGiftData" },
			Name = "SisyphusVanillaKeepsake",
		}
	end

	-- Creating Keepsake Data
	game.TraitData.SisyphusVanillaKeepsake = {
		Icon = "Shattered_Shackle",
		InheritFrom = { "GiftTrait" },
		Name = "SisyphusVanillaKeepsake",
		CustomTrayText = "SisyphusVanillaKeepsake_Tray",

		-- Always add these, so it SHUTS UP
		ShowInHUD = true,
		Ordered = true,
		HUDScale = 0.435,
		PriorityDisplay = true,
		ChamberThresholds = { 25, 50 },
		HideInRunHistory = true,
		Slot = "Keepsake",
		InfoBackingAnimation = "KeepsakeSlotBase",
		RecordCacheOnEquip = true,
		TraitOrderingValueCache = -1,
		ActiveSlotOffsetIndex = 0,

		FrameRarities = {
			Common = "Frame_Keepsake_Rank1",
			Rare = "Frame_Keepsake_Rank2",
			Epic = "Frame_Keepsake_Rank3",
			Heroic = "Frame_Keepsake_Rank4",
		},

		CustomRarityLevels = {
			"TraitLevel_Keepsake1",
			"TraitLevel_Keepsake2",
			"TraitLevel_Keepsake3",
			"TraitLevel_Keepsake4",
		},

		RarityLevels = {
			Common = { Multiplier = config.Sisyphus.a_KeepsakeCommon },
			Rare = { Multiplier = config.Sisyphus.b_KeepsakeRare },
			Epic = { Multiplier = config.Sisyphus.c_KeepsakeEpic },
			Heroic = { Multiplier = config.Sisyphus.d_KeepsakeHeroic },
		},

		AddOutgoingDamageModifiers = {
			EmptySlotMultiplier = { BaseValue = 1.5, SourceIsMultiplier = true },
			EmptySlotValidData = {
				Melee = WeaponSets.HeroNonExWeapons,
				Secondary = WeaponSets.HeroSecondaryWeapons,
				Ranged = WeaponSets.HeroNonPhysicalWeapons,
			},
			ReportValues = { ReportedWeaponMultiplier = "EmptySlotMultiplier" },
		},

		ExtractValues = {
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipBonus",
				Format = "PercentDelta",
				SkipAutoExtract = true,
			},
		},

		SignOffData = {
			{
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", "SisyphusGift09_A" },
					},
				},
				Text = "SignoffSisyphus_Max",
			},
			{
				Text = "SignoffSisyphus",
			},
		},
	}
end

-- =================================================
--                 Sisyphus SJSON
-- =================================================
-- Used for when you have it equipped
local keepsake_sisyphus = sjson.to_object({
	Id = "SisyphusVanillaKeepsake_Tray",
	InheritFrom = "SisyphusVanillaKeepsake",
	Description = "Your {$Keywords.Attack}, {$Keywords.Special} and {$Keywords.Cast} each deal {#UpgradeFormat}{$TooltipData.ExtractData.TooltipBonus:P} {#Prev}damage while not empowered by a {$Keywords.GodBoon}.",
}, Order)

-- In rack description
local keepsakerack_sisyphus = sjson.to_object({
	Id = "SisyphusVanillaKeepsake",
	InheritFrom = "BaseBoonMultiline",
	DisplayName = "Shattered Shackle",
	Description = "Your {$Keywords.Attack}, {$Keywords.Special} and {$Keywords.Cast} each deal {#UpgradeFormat}{$TooltipData.ExtractData.TooltipBonus:P} {#Prev}damage while not empowered by a {$Keywords.GodBoon}.",
}, Order)

local signoff_sisyphus = sjson.to_object({
	Id = "SignoffSisyphus",
	DisplayName = "From Sisyphus",
}, Order)

local signoff_sisyphusmax = sjson.to_object({
	Id = "SignoffSisyphus_Max",
	DisplayName = "From {#AwardMaxFormat}Sisyphus{#Prev}; you share a {#AwardMaxFormat}Rock-Solid Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}If he can hoist a boulder on his own, he knows he can be of some support.",
}, Order)

-- Icon JSON data
local keepsakeicon_sisyphus = sjson.to_object({
	Name = "Shattered_Shackle",
	InheritFrom = "KeepsakeIcon",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\Shattered_Shackle"),
}, IconOrder)

local keepsakemaxCorner_sisyphus = sjson.to_object({
	Name = "Keepsake_Sisyphus_Corner",
	InheritFrom = "KeepsakeMax_Corner",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Sisyphus"),
}, IconOrder)

local keepsakemax_sisyphus = sjson.to_object({
	Name = "Keepsake_Sisyphus",
	InheritFrom = "KeepsakeMax",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Sisyphus_02"),
}, IconOrder)

-- Inserting into SJSON
sjson.hook(TraitTextFile, function(data)
	table.insert(data.Texts, keepsake_sisyphus)
	table.insert(data.Texts, keepsakerack_sisyphus)
	table.insert(data.Texts, signoff_sisyphus)
	table.insert(data.Texts, signoff_sisyphusmax)
end)

-- Insert for Icons
sjson.hook(GUIBoonsVFXFile, function(data)
	table.insert(data.Animations, keepsakeicon_sisyphus)
	table.insert(data.Animations, keepsakemaxCorner_sisyphus)
	table.insert(data.Animations, keepsakemax_sisyphus)
end)

CreateKeepsake_Sisyphus()
