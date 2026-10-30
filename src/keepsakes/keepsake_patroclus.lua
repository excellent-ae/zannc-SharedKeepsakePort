local maxReq = {}
local minReq = {}

if mod.hades_Biomes then
	maxReq = {
		PathTrue = { "GameState", "TextLinesRecord", "PatroclusGift08_A" },
	}
	minReq = {
		PathTrue = { "GameState", "TextLinesRecord", "PatroclusGift01" },
	}
end

gods.CreateKeepsake({
	characterName = "Patroclus",
	internalKeepsakeName = "ShieldAfterHitKeepsake",

	RarityLevels = {
		Common = { Multiplier = config.Patroclus.a_KeepsakeCommon },
		Rare = { Multiplier = config.Patroclus.b_KeepsakeRare },
		Epic = { Multiplier = config.Patroclus.c_KeepsakeEpic },
		Heroic = { Multiplier = config.Patroclus.d_KeepsakeHeroic },
	},

	ExtractValues = {
		{
			Key = "ReportedDuration",
			ExtractAs = "ShieldDuration",
			Format = "SpeedModifiedDuration",
			DecimalPlaces = 2,
			-- SkipAutoExtract = true,
		},
	},

	EquipSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

	Keepsake = {
		displayName = "Broken Spearpoint",
		description = "After taking damage, become {$Keywords.Invulnerable} for {#AltUpgradeFormat}{$TooltipData.ExtractData.ShieldDuration} second(s){#Prev}. Refreshes after {#BoldFormat}7 seconds{#BoldFormat}.",
		trayDescription = "After taking damage, become {$Keywords.Invulnerable} for {#AltUpgradeFormat}{$TooltipData.ExtractData.ShieldDuration} second(s){#Prev}. Refreshes after {#BoldFormat}7 seconds{#BoldFormat}.",
		signoffMax = "From {#AwardMaxFormat}Patroclus{#Prev}; you share an {#AwardMaxFormat}Enlightened Bond{#Prev}.{!Icons.ObjectiveSeparatorDark}He passed bitterly from mortal life, but with you, rose above it all.",
	},

	Icons = {
		iconPath = "GUI\\Screens\\AwardMenu\\Broken_Spearpoint",
		maxIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Patroclus_02",
		maxCornerIcon = "GUI\\Screens\\AwardMenu\\KeepsakeMaxGift\\Patroclus",
	},

	customGiftData = {
		customName = "NPC_Patroclus_01",
		maxRequirement = maxReq,
		minRequirement = minReq,
	},

	ExtraFields = {
		OnSelfDamagedFunction = {
			Name = _PLUGIN.guid .. "." .. "PatroclusRetaliate",
			FunctionArgs = {
				EffectName = _PLUGIN.guid .. "PatroclusInvulnerable",

				Duration = { BaseValue = 1.0 },
				Cooldown = 7,

				ReportValues = {
					ReportedDuration = "Duration",
				},
			},
		},
	},
})

game.EffectData[_PLUGIN.guid .. "PatroclusInvulnerable"] = {
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

function mod.PatroclusRetaliate(unit, args, triggerArgs)
	local victim = triggerArgs.Victim

	if not victim or not victim.Health or victim.Health < 0 or victim.IsDead then
		return
	end

	local cooldown = args.Cooldown or 7.0
	local cooldownName = "PatroclusInvulnerability" .. victim.ObjectId

	if not CheckCooldown(cooldownName, args.Cooldown) or triggerArgs.DamageAmount <= 0 then
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
