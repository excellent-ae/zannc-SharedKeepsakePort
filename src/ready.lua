---@meta _
---@diagnostic disable: lowercase-global
-- Absolute Path links to plugins_data folder - mod folder, then package name - which MUST contain mod author name for uniqueness
local package = rom.path.combine(_PLUGIN.plugins_data_mod_folder_path, _PLUGIN.guid)
-- Example Output of Package Path:
-- C:\Program Files (x86)\Steam\steamapps\common\Hades II\Ship\ReturnOfModding\plugins_data\zannc-KeepsakePort\zannc-KeepsakePort
modutil.mod.Path.Wrap("SetupMap", function(base)
    game.LoadPackages({ Name = package })
    base()
end)

mod.patroKeepsakeName = gods.GetInternalKeepsakeName("ShieldAfterHitKeepsake")
mod.thanaKeepsakeName = gods.GetInternalKeepsakeName("PerfectClearDamageBonusKeepsake")
mod.hermesKeepsakeName = gods.GetInternalKeepsakeName("FastClearDodgeBonusKeepsake")

modutil.mod.Path.Wrap("StartEncounterEffects", function(base, encounter)
    local currentRun = game.CurrentRun
    local currentRoom = currentRun.CurrentRoom

    --TODO Check this code.
    encounter = encounter or CurrentRun.CurrentRoom.Encounter
    encounter.StartTime = CurrentRun.GameplayTime

    -- Assign a start counter to all active encounters, specifically for Hermes boon
    -- if currentRoom.ActiveEncounters ~= nil then
    -- 	for k, encounter in pairs(currentRoom.ActiveEncounters) do
    -- 		encounter.StartTime = _worldTime
    -- 	end
    -- end

    if HeroHasTrait(mod.patroKeepsakeName) then
        local traitData = GetHeroTrait(mod.patroKeepsakeName)
        if
            traitData.OnSelfDamagedFunction
            and traitData.OnSelfDamagedFunction.FunctionArgs
            and traitData.OnSelfDamagedFunction.FunctionArgs.Cooldown
            and CheckCooldownNoTrigger("PatroclusInvulnerability" .. CurrentRun.Hero.ObjectId, traitData.OnSelfDamagedFunction.FunctionArgs.Cooldown, true)
        then
            TraitUIActivateTrait(traitData)
        end
    end

    if HeroHasTrait(mod.thanaKeepsakeName) then
        local traitData = GetHeroTrait(mod.thanaKeepsakeName)
        if currentRoom and not game.CurrentRun.Hero.IsDead and currentRoom.Encounter ~= nil and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed and not currentRoom.Encounter.PlayerTookDamage then
            TraitUIActivateTrait(traitData)
        end
    end

    if HeroHasTrait(mod.hermesKeepsakeName) then
        local traitData = GetHeroTrait(mod.hermesKeepsakeName)
        if currentRoom and not game.CurrentRun.Hero.IsDead and currentRoom.Encounter ~= nil and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed then
            mod.SetupDodgeBonus(currentRoom.Encounter, traitData)
        end
    end
    base(encounter)
end)

modutil.mod.Path.Wrap("EndEncounterEffects", function(base, currentRun, currentRoom, currentEncounter)
    if GetHeroTrait(mod.patroKeepsakeName) then
        TraitUIDeactivateTrait(GetHeroTrait(mod.patroKeepsakeName))
    end

    -- thinking I could check for all to be completed, maybe through the thread which opens the doors
    -- ExitsDontRequireCompleted
    -- function FieldsEncounterEndPresentation( encounter, currentRun )
    -- function CheckForEncounterEnemiesDead( eventSource, args )

    if not currentEncounter.SkipEndEncounterEffects and (currentEncounter == currentRoom.Encounter and currentEncounter.EncounterType ~= "NonCombat" or currentEncounter == game.MapState.EncounterOverride) then -- and not currentRoom.TimerBlock
        currentEncounter.ClearTime = nil
        if currentEncounter.StartTime then
            currentEncounter.ClearTime = currentRun.GameplayTime - currentEncounter.StartTime
        else
            currentEncounter.ClearTime = 999 --random high number
            rom.log.warning("StartTime was nil for encounter " .. (currentEncounter.Name or "nil"))
        end

        -- For Hermes in fields, very crude but hopefully works, makes it so if encounter has threshold
        -- calculate the clear time, else set clear time to arbritrary high number to fail encounter automatically (done to combat NPC rooms)
        -- if currentEncounter.FastClearThreshold then
        -- if currentEncounter.FastClearThreshold then
        -- 	for k, encounter in pairs(CurrentRun.CurrentRoom.ActiveEncounters) do
        -- 		-- Check clear time, used later in original function
        -- 		encounter.ClearTime = currentRun.GameplayTime - encounter.StartTime
        -- 	end
        -- else
        -- 	-- If no threshold, either its undefined, broken, or NPC/NonCombat room, set clear time to 200 to auto fail hermes
        -- 	currentEncounter.ClearTime = 200
        -- end

        for k, traitData in pairs(CurrentRun.Hero.Traits) do
            if traitData.FastClearThreshold then
                -- local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
                if currentEncounter.ClearTime < (currentEncounter.FastClearThreshold or traitData.FastClearThreshold) and traitData.FastClearDodgeBonus then
                    local lastDodgeBonus = traitData.AccumulatedDodgeBonus
                    SetLifeProperty({ Property = "DodgeChance", Value = -1 * lastDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
                    SetUnitProperty({ Property = "Speed", Value = 1 / (1 + lastDodgeBonus), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })

                    traitData.AccumulatedDodgeBonus = traitData.AccumulatedDodgeBonus + traitData.FastClearDodgeBonus

                    SetLifeProperty({ Property = "DodgeChance", Value = traitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
                    SetUnitProperty({ Property = "Speed", Value = 1 + traitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
                    mod.FastClearTraitSuccessPresentation(traitData)
                    UpdateTraitNumber(GetHeroTrait(mod.hermesKeepsakeName))
                else
                    TraitUIDeactivateTrait(GetHeroTrait(mod.hermesKeepsakeName))
                end
            end
        end

        -- For Thanatos
        if game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage ~= nil then
            currentEncounter.PlayerTookDamage = game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
        end

        -- if not currentRoom.BlockClearRewards then
        for k, traitData in pairs(CurrentRun.Hero.Traits) do
            if not currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
                traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
                mod.PerfectClearTraitSuccessPresentation(traitData)
                UpdateTraitNumber(GetHeroTrait(mod.thanaKeepsakeName))

                -- CurrentRun.CurrentRoom.PerfectEncounterCleared = true
            elseif currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
                mod.PerfectClearTraitFailedPresentation(traitData)
            end
        end
    end
    base(currentRun, currentRoom, currentEncounter)
end)

modutil.mod.Path.Wrap("RemoveTraitData", function(base, unit, trait, args)
    if trait.AccumulatedDodgeBonus then
        SetLifeProperty({ Property = "DodgeChance", Value = -1 * trait.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
        SetUnitProperty({ Property = "Speed", Value = 1 / (1 + trait.AccumulatedDodgeBonus), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
    end
    base(unit, trait, args)
end)

modutil.mod.Path.Wrap("DamageHero", function(base, victim, triggerArgs)
    if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 and not triggerArgs.Silent then
        if game.CurrentRun.CurrentRoom.Encounter ~= nil and game.CurrentRun.CurrentRoom.Encounter.InProgress and not triggerArgs.PureDamage then
            game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage = true

            if HeroHasTrait(mod.thanaKeepsakeName) then
                local traitData = GetHeroTrait(mod.thanaKeepsakeName)
                TraitUIDeactivateTrait(traitData)
            end
        end
    end
    base(victim, triggerArgs)

    local currentHealth = game.CurrentRun.Hero.Health
    -- local currentHealthFraction = victim.Health / victim.MaxHealth
    local lowHealthText = {}
    for i, traitData in ipairs(CurrentRun.Hero.Traits) do
        local thresholdData = traitData.LowHealthThresholdText
        if thresholdData ~= nil and currentHealth / CurrentRun.Hero.MaxHealth <= thresholdData.PercentThreshold then -- and (currentHealth + triggerArgs.DamageAmount) / CurrentRun.Hero.MaxHealth > thresholdData.PercentThreshold
            lowHealthText[traitData.Name] = thresholdData.Text
            TraitUIActivateTrait(traitData)
        end
    end
    if not IsEmpty(lowHealthText) and not triggerArgs.Silent then
        thread(HighHealthCombatTextPresentation, victim.ObjectId, lowHealthText)
    end
end)

modutil.mod.Path.Wrap("Heal", function(base, victim, triggerArgs)
    base(victim, triggerArgs)
    -- local prevHealth = victim.Health
    -- triggerArgs.ActualHealAmount = round(victim.Health - prevHealth)
    if victim == CurrentRun.Hero then
        for i, traitData in pairs(CurrentRun.Hero.Traits) do
            local thresholdData = traitData.LowHealthThresholdText
            if thresholdData ~= nil and CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth >= thresholdData.PercentThreshold then -- and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount) / CurrentRun.Hero.MaxHealth <= thresholdData.PercentThreshold
                TraitUIDeactivateTrait(traitData)
            end
        end
    end
end)

modutil.mod.Path.Wrap("TraitUICreateText", function(base, trait, args)
    base(trait, args)
    if trait.CustomLabel then
        if trait.AccumulatedDamageBonus then --* Thanatos
            local total = (trait.AccumulatedDamageBonus - 1) * 100
            local text = "UI_TimedKillBuff"
            CreateTextBox({
                Id = trait.TraitInfoCardId,
                Text = text,
                Font = "P22UndergroundSCMedium",
                FontSize = 22,
                Color = Color.White,
                ShadowBlur = 0,
                ShadowColor = { 0, 0, 0, 1 },
                ShadowOffset = { 1, 2 },
                -- OffsetX = xOffset,
                -- OffsetY = yOffset,
                Justification = "Center",
                DataProperties = {
                    TextSymbolScale = 0.7,
                    TextSymbolOffsetY = 3,
                },
                LuaKey = "TempTextData",
                LuaValue = { Value = total },
            })
        end
        if trait.AccumulatedDodgeBonus then --* Hermes
            local total = trait.AccumulatedDodgeBonus * 100
            local text = "UI_TimedKillBuff"
            CreateTextBox({
                Id = trait.TraitInfoCardId,
                Text = text,
                Font = "P22UndergroundSCMedium",
                FontSize = 22,
                Color = Color.White,
                ShadowBlur = 0,
                ShadowColor = { 0, 0, 0, 1 },
                ShadowOffset = { 1, 2 },
                -- OffsetX = xOffset,
                -- OffsetY = yOffset,
                Justification = "Center",
                DataProperties = {
                    TextSymbolScale = 0.7,
                    TextSymbolOffsetY = 3,
                },
                LuaKey = "TempTextData",
                LuaValue = { Value = total },
            })
        end
    end
end)

--#region hermes fail/success/thread
local function FastClearTraitFailedPresentation(traitData)
    TraitUIDeactivateTrait(traitData)
    PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail" })
    Flash({ Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, ExpireAfterCycle = true })
    ShakeScreen({ Speed = 400, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })
end

local function FastClearThread(clearTimeThreshold, dodgeTraitData)
    wait(clearTimeThreshold, RoomThreadName)
    if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and not CurrentRun.CurrentRoom.Encounter.Completed and not CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
        FastClearTraitFailedPresentation(dodgeTraitData)
    end
end

local function FastClearTraitStartPresentation(clearTimeThreshold, traitData)
    PlaySound({ Name = "/EmptyCue" })
    TraitUIActivateTrait(traitData, { CustomAnimation = "ActiveTraitSingle_Custom", PlaySpeed = 30 / clearTimeThreshold })
end

function mod.SetupDodgeBonus(encounter, dodgeTraitData)
    if CurrentRun == nil or CurrentRun.Hero == nil or CurrentRun.Hero.IsDead then
        return
    end
    SetLifeProperty({ Property = "DodgeChance", Value = dodgeTraitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
    SetUnitProperty({ Property = "Speed", Value = 1 + dodgeTraitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
    local clearTimeThreshold = encounter.FastClearThreshold or dodgeTraitData.FastClearThreshold
    FastClearTraitStartPresentation(clearTimeThreshold, dodgeTraitData)

    thread(FastClearThread, clearTimeThreshold, dodgeTraitData)
end

function mod.FastClearTraitSuccessPresentation(traitData)
    TraitUIDeactivateTrait(traitData)
    wait(0.50)
    thread(PlayVoiceLines, HeroVoiceLines.FastClearDodgeBonusUpgradedVoiceLines, true)
    local existingTraitData = GetExistingUITrait(traitData)
    if existingTraitData then
        Flash({ Id = existingTraitData.AnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.LimeGreen, ExpireAfterCycle = true })
        CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
    end
    thread(InCombatText, CurrentRun.Hero.ObjectId, "zannc-SharedKeepsakePort-Hint_ReportedxBonus", 2.0, { ShadowScaleX = 1.5, LuaKey = "TempTextData", LuaValue = { Amount = (traitData.FastClearDodgeBonus * 100) } })
    local soundId = PlaySound({ Name = "/SFX/Player Sounds/HermesWhooshDashReverse" })
    PlaySound({ Name = "/Leftovers/SFX/PositiveTalismanProc_3" })
    SetVolume({ Id = soundId, Value = 0.3 })
    CreateAnimation({ Name = "HermesWings", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
    ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })
end

--#endregion

function mod.PerfectClearTraitFailedPresentation(traitData)
    wait(0.30)
    TraitUIDeactivateTrait(traitData)
    PlaySound({ Name = "/SFX/ThanatosHermesKeepsakeFail" })
    -- thread(PlayVoiceLines, HeroVoiceLines.KeepsakeChallengeFailedVoiceLines, true)
    -- local existingTraitData = GetExistingUITrait(traitData)
    -- if existingTraitData and existingTraitData.AnchorId ~= nil then
    -- 	Shake({ Id = existingTraitData.AnchorId, Distance = 3, Speed = 200, Duration = 0.25 })
    -- end
    Flash({ Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.Black, ExpireAfterCycle = true })
    ShakeScreen({ Speed = 400, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })
end

function mod.PerfectClearTraitSuccessPresentation(traitData)
    TraitUIDeactivateTrait(traitData)
    wait(0.50)
    local existingTraitData = GetExistingUITrait(traitData)
    if existingTraitData ~= nil and existingTraitData.AnchorId ~= nil then
        CreateAnimation({ Name = "KeepsakeSparkleEmitter", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
        PlaySound({ Name = existingTraitData.EquipSound or "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY", Id = CurrentRun.Hero.ObjectId })
    end
    CreateAnimation({ Name = "KeepsakeLevelUpFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
    local soundId = PlaySound({ Name = "/SFX/ThanatosAttackBell", Id = CurrentRun.Hero.ObjectId })
    SetVolume({ Id = soundId, Value = 0.3 })
    thread(InCombatText, CurrentRun.Hero.ObjectId, "zannc-SharedKeepsakePort-Hint_ReportedxBonus", 2.0, { ShadowScaleX = 1.5, LuaKey = "TempTextData", LuaValue = { Amount = (traitData.PerfectClearDamageBonus - 1) * 100 } })
    ShakeScreen({ Speed = 200, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })
end
