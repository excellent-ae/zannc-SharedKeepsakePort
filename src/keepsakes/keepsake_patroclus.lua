local mods = rom.mods
local hades_Biomes = mods["NikkelM-Hades_Biomes"]

function CreateKeepsake_Patroclus()
	-- Creating Keepsake Order
	table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "ShieldAfterHitKeepsake")

	-- Creating Gift Data
	if hades_Biomes then
		game.GiftData.NPC_Patroclus_01 = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = {
				{
					PathTrue = { "GameState", "TextLinesRecord", "PatroclusGift08_A" },
				},
			},
			MaxedIcon = "Keepsake_Patroclus_Corner",
			MaxedSticker = "Keepsake_Patroclus",
			[1] = {
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", "PatroclusGift01" },
					},
				},
				Gift = "ShieldAfterHitKeepsake",
			},
		}
	else
		game.GiftData.NPC_Patroclus_01 = {
			[1] = {
				Gift = "ShieldAfterHitKeepsake",
			},
			InheritFrom = { "DefaultGiftData" },
			Name = "ShieldAfterHitKeepsake",
		}
	end

	game.EffectData.PatroclusInvulnerable = {
		ShowInvincububble = true,
		DataProperties = {
			Type = "INVULNERABLE",
			Duration = 8,
			Modifier = 1.0,
			CanAffectInvulnerable = true,
			FlashFrontFxWhenExpiring = false,
			FlashBackFxWhenExpiring = false,
		},
	}

	-- Creating Keepsake Data
	game.TraitData.ShieldAfterHitKeepsake = {
		Icon = "Broken_Spearpoint",
		InheritFrom = { "GiftTrait" },
		Name = "ShieldAfterHitKeepsake",
		CustomTrayText = "ShieldAfterHitKeepsake_Tray",

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

		EquipSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

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
			Common = { Multiplier = config.Patroclus.a_KeepsakeCommon },
			Rare = { Multiplier = config.Patroclus.b_KeepsakeRare },
			Epic = { Multiplier = config.Patroclus.c_KeepsakeEpic },
			Heroic = { Multiplier = config.Patroclus.d_KeepsakeHeroic },
		},

		OnSelfDamagedFunction = {
			Name = _PLUGIN.guid .. "." .. "PatroclusRetaliate",
			FunctionArgs = {
				EffectName = "PatroclusInvulnerable",

				Duration = { BaseValue = 1.0 },
				Cooldown = 7,

				ReportValues = {
					ReportedDuration = "Duration",
				},
			},
		},

		ExtractValues = {
			{
				Key = "ReportedDuration",
				ExtractAs = "ShieldDuration",
				Format = "SpeedModifiedDuration",
				-- SkipAutoExtract = true,
			},
		},

		SignOffData = {
			{
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", "PatroclusGift08_A" },
					},
				},
				Text = "SignoffPatroclus_Max",
			},
			{
				Text = "SignoffPatroclus",
			},
		},
	}
end

--#region Patroclus Data
-- Used for when you have it equipped
local keepsake_patroclus = sjson.to_object({
	Id = "ShieldAfterHitKeepsake_Tray",
	InheritFrom = "ShieldAfterHitKeepsake",
	Description = "After taking damage, become {$Keywords.Invulnerable} for {#AltUpgradeFormat}{$TooltipData.ExtractData.ShieldDuration} second(s){#Prev}. Refreshes after {#BoldFormat}7 seconds{#BoldFormat}.",
}, Order)

-- In rack description
local keepsakerack_patroclus = sjson.to_object({
	Id = "ShieldAfterHitKeepsake",
	InheritFrom = "BaseBoonMultiline",
	DisplayName = "Shattered Shackle",
	Description = "After taking damage, become {$Keywords.Invulnerable} for {#AltUpgradeFormat}{$TooltipData.ExtractData.ShieldDuration} second(s){#Prev}. Refreshes after {#BoldFormat}7 seconds{#BoldFormat}.",
}, Order)

local signoff_patroclus = sjson.to_object({
	Id = "SignoffPatroclus",
	DisplayName = "From Patroclus",
}, Order)

local signoff_patroclusmax = sjson.to_object({
	Id = "SignoffPatroclus_Max",
	DisplayName = "From {#AwardMaxFormat}Patroclus{#Prev}; you share an {#AwardMaxFormat}Enlightened Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}}He passed bitterly from mortal life, but with you, rose above it all.",
}, Order)

-- Icon JSON data
local keepsakeicon_patroclus = sjson.to_object({
	Name = "Broken_Spearpoint",
	InheritFrom = "KeepsakeIcon",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\Broken_Spearpoint"),
}, IconOrder)

local keepsakemaxCorner_patroclus = sjson.to_object({
	Name = "Keepsake_Patroclus_Corner",
	InheritFrom = "KeepsakeMax_Corner",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Patroclus"),
}, IconOrder)

local keepsakemax_patroclus = sjson.to_object({
	Name = "Keepsake_Patroclus",
	InheritFrom = "KeepsakeMax",
	FilePath = rom.path.combine(_PLUGIN.guid, "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Patroclus_02"),
}, IconOrder)

-- Inserting into SJSON
sjson.hook(TraitTextFile, function(data)
	table.insert(data.Texts, keepsake_patroclus)
	table.insert(data.Texts, keepsakerack_patroclus)
	table.insert(data.Texts, signoff_patroclus)
	table.insert(data.Texts, signoff_patroclusmax)
end)

-- Insert for Icons
sjson.hook(GUIBoonsVFXFile, function(data)
	table.insert(data.Animations, keepsakeicon_patroclus)
	table.insert(data.Animations, keepsakemaxCorner_patroclus)
	table.insert(data.Animations, keepsakemax_patroclus)
end)
--#endregion

function mod.PatroclusRetaliate(unit, args, triggerArgs)
	local victim = triggerArgs.Victim
	local cooldown = args.Cooldown or 7.0
	local cooldownName = "PatroclusInvulnerability" .. victim.ObjectId

	if not victim or not victim.Health or victim.Health < 0 or victim.IsDead or not CheckCooldown(cooldownName, args.Cooldown) or triggerArgs.DamageAmount <= 0 then
		return
	end

	local dataProperties = ShallowCopyTable(EffectData[args.EffectName].DataProperties)
	dataProperties.Duration = args.Duration or 1
	ApplyEffect({ DestinationId = victim.ObjectId, Id = CurrentRun.Hero.ObjectId, EffectName = args.EffectName, DataProperties = dataProperties })

	local traitData = GetHeroTrait("ShieldAfterHitKeepsake")
	if traitData then
		-- local functionArgs = traitData.OnSelfDamagedFunction.FunctionArgs
		TraitUIActivateTrait(traitData, { FlashOnActive = true, Duration = cooldown })
	end
end

CreateKeepsake_Patroclus()
