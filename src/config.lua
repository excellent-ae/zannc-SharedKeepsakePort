---@meta zannc-SharedKeepsakePort-config

local config = {
    enabled = true,

    Sisyphus = {
        Enabled = true,
        a_KeepsakeCommon = 1.0,
        b_KeepsakeRare = 1.5,
        c_KeepsakeEpic = 2.0,
        d_KeepsakeHeroic = 2.5,
    },

    Patroclus = {
        Enabled = true,
        a_KeepsakeCommon = 1.0,
        b_KeepsakeRare = 1.25,
        c_KeepsakeEpic = 1.5,
        d_KeepsakeHeroic = 2.0,
    },

    Eurydice = {
        Enabled = true,
        a_KeepsakeCommon = 3,
        b_KeepsakeRare = 4,
        c_KeepsakeEpic = 5,
        d_KeepsakeHeroic = 6,
    },

    Thanatos = {
        Enabled = true,
        a_KeepsakeCommon = 1.0,
        b_KeepsakeRare = 1.5,
        c_KeepsakeEpic = 2.0,
        d_KeepsakeHeroic = 2.5,
    },

    Orpheus = {
        Enabled = true,
        a_KeepsakeCommon = 1.0,
        b_KeepsakeRare = 2.0,
        c_KeepsakeEpic = 3.0,
        d_KeepsakeHeroic = 4.0,
    },

    Megaera = {
        Enabled = true,
        a_KeepsakeCommon = 1.0,
        b_KeepsakeRare = 1.5,
        c_KeepsakeEpic = 2.0,
        d_KeepsakeHeroic = 3.0,
    },

    Achilles = {
        Enabled = true,
        a_KeepsakeCommon = 2.0,
        b_KeepsakeRare = 2.5,
        c_KeepsakeEpic = 3.0,
        d_KeepsakeHeroic = 4.0,
    },

    Dusa = {
        Enabled = true,
        a_KeepsakeCommon = 1.0,
        b_KeepsakeRare = 1.5,
        c_KeepsakeEpic = 2.0,
        d_KeepsakeHeroic = 2.5,
    },
}

local descriptions = {
    enabled = "Set to true to enable the mod, false to disable.",

    Sisyphus = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game",
        a_KeepsakeCommon = "Increase value to increase damage gained from having no core boons.",
    },

    Eurydice = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game.",
        a_KeepsakeCommon = "Increase value to increase the amount of times you have a shield in the final encounter per region.",
    },

    Patroclus = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game.",
        a_KeepsakeCommon = "Increase value to increase invincibility duration (in seconds).",
    },

    Thanatos = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game",
        a_KeepsakeCommon = "Increase value to increase damage bonus gained per room, decrease for opposite effect.\nExample: 2.0 will set bonus to +2.0% per room, 0.5 will set it to +0.5% per room",
    },

    Orpheus = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game",
        a_KeepsakeCommon = "Increase value to increase damage bonus when further than 500 units.",
    },

    Megaera = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game",
        a_KeepsakeCommon = "Increase value to increase damage, decrease for opposite effect.\nExample: 3.0 will set bonus to 60%, 0.5 will set it to +10%",
    },

    Achilles = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game",
        a_KeepsakeCommon = "Increase value to decrease damage taken, decrease for opposite effect.\nExample: 3.0 will reduce damage by 30%, 1.5 will reduce it by 15%",
    },

    Dusa = {
        Enabled = "Set to true to enable keepsake, false to disable.\nNOTE: When disabling keepsakes, make sure you unequip them and save your game",
        a_KeepsakeCommon = "Increase value to increase the chance of a broken urn dropping a healing item, decrease for opposite effect.\nExample: 1.0 gives a 3% chance, 2.0 gives 6%, and 0.5 gives 1.5%",
    },
}

return config, descriptions
