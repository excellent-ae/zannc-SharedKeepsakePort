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

function TraitUIActivateTraits_Wrap(base, args)
	CheckForKeepsakeTraits()
end
