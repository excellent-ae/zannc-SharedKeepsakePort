local mods = rom.mods
local hades_Biomes = mods["NikkelM-Hades_Biomes"]

function CreateKeepsake_Eurydice()
	-- Creating Keepsake Order
	table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "ShieldBossKeepsake")

	-- Creating Gift Data
	if hades_Biomes then
		game.GiftData.NPC_Eurydice_01 = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = {
				{
					PathTrue = { "GameState", "TextLinesRecord", "EurydiceGift09_A" },
				},
			},
			MaxedIcon = "Keepsake_Eurydice_Corner",
			MaxedSticker = "Keepsake_Eurydice",
			[1] = {
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", "EurydiceGift01" },
					},
				},
				Gift = "ShieldBossKeepsake",
			},
		}
	else
		game.GiftData.NPC_Eurydice_01 = {
			[1] = {
				Gift = "ShieldBossKeepsake",
			},
			InheritFrom = { "DefaultGiftData" },
			Name = "ShieldBossKeepsake",
		}
	end

	-- Creating Keepsake Data
	game.TraitData.ShieldBossKeepsake = {
		Icon = "Evergreen_Acorn",
		InheritFrom = { "GiftTrait" },
		Name = "ShieldBossKeepsake",
		CustomTrayText = "ShieldBossKeepsake_Tray",

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

		EquipSound = "/SFX/Menu Sounds/KeepsakeEurydiceAcorn",

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
			Common = { Multiplier = config.Eurydice.a_KeepsakeCommon },
			Rare = { Multiplier = config.Eurydice.b_KeepsakeRare },
			Epic = { Multiplier = config.Eurydice.c_KeepsakeEpic },
			Heroic = { Multiplier = config.Eurydice.d_KeepsakeHeroic },
		},

		BossEncounterShieldHits = { BaseValue = 1 },
		BossShieldFx = "MelShieldFront",
		ExtractValues = {
			{
				Key = "BossEncounterShieldHits",
				ExtractAs = "TooltipHits",
			},
		},

		SignOffData = {
			{
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", "EurydiceGift09_A" },
					},
				},
				Text = "SignoffEurydice_Max",
			},
			{
				Text = "SignoffEurydice",
			},
		},
	}
end

--#region Eurydice Data
-- Used for when you have it equipped
local keepsake_eurydice = sjson.to_object({
	Id = "ShieldBossKeepsake_Tray",
	InheritFrom = "ShieldBossKeepsake",
	Description = "In the final encounter in each region, take {#BoldFormatGraft}0 {#Prev}damage the first {#AltUpgradeFormat}{$TooltipData.ExtractData.TooltipHits} {#Prev}times foes hit you.",
}, Order)

-- In rack description
local keepsakerack_eurydice = sjson.to_object({
	Id = "ShieldBossKeepsake",
	InheritFrom = "BaseBoonMultiline",
	DisplayName = "Evergreen Acorn",
	Description = "In the final encounter in each region, take {#BoldFormatGraft}0 {#Prev}damage the first {#AltUpgradeFormat}{$TooltipData.ExtractData.TooltipHits} {#Prev}times foes hit you.",
}, Order)

local signoff_eurydice = sjson.to_object({
	Id = "SignoffEurydice",
	DisplayName = "From Eurydice",
}, Order)

local signoff_eurydicemax = sjson.to_object({
	Id = "SignoffEurydice_Max",
	DisplayName = "From {#AwardMaxFormat}Eurydice{#Prev}; you share an {#AwardMaxFormat}Inspiring Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}}Singing for the joy of it, she lives for the moment, even in death.",
}, Order)

-- Icon JSON data
local keepsakeicon_eurydice = sjson.to_object({
	Name = "Evergreen_Acorn",
	InheritFrom = "KeepsakeIcon",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\Evergreen_Acorn"),
}, IconOrder)

local keepsakemaxCorner_eurydice = sjson.to_object({
	Name = "Keepsake_Eurydice_Corner",
	InheritFrom = "KeepsakeMax_Corner",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Eurydice"),
}, IconOrder)

local keepsakemax_eurydice = sjson.to_object({
	Name = "Keepsake_Eurydice",
	InheritFrom = "KeepsakeMax",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Eurydice_02"),
}, IconOrder)

-- Inserting into SJSON
sjson.hook(TraitTextFile, function(data)
	table.insert(data.Texts, keepsake_eurydice)
	table.insert(data.Texts, keepsakerack_eurydice)
	table.insert(data.Texts, signoff_eurydice)
	table.insert(data.Texts, signoff_eurydicemax)
end)

-- Insert for Icons
sjson.hook(GUIBoonsVFXFile, function(data)
	table.insert(data.Animations, keepsakeicon_eurydice)
	table.insert(data.Animations, keepsakemaxCorner_eurydice)
	table.insert(data.Animations, keepsakemax_eurydice)
end)
--#endregion

CreateKeepsake_Eurydice()
