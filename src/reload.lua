---@meta _
---@diagnostic disable: lowercase-global

local function CheckForKeepsakeTraits(args)
	if HeroHasTrait("ShieldAfterHitKeepsake") then
		local traitData = GetHeroTrait("ShieldAfterHitKeepsake")
		if
			traitData.OnSelfDamagedFunction
			and traitData.OnSelfDamagedFunction.FunctionArgs
			and traitData.OnSelfDamagedFunction.FunctionArgs.Cooldown
			and CheckCooldownNoTrigger("PatroclusInvulnerability" .. CurrentRun.Hero.ObjectId, traitData.OnSelfDamagedFunction.FunctionArgs.Cooldown, true)
		then
			TraitUIActivateTrait(traitData, args)
		end
	end
end

function EndEncounterEffects_wrap(base, currentRun, currentRoom, currentEncounter)
	local traitData = GetHeroTrait("ShieldAfterHitKeepsake")

	if traitData then
		TraitUIDeactivateTrait(traitData)
	end
end

function TraitUIActivateTraits_Wrap(base, args)
	CheckForKeepsakeTraits()
end
