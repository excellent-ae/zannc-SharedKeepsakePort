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
}

return config, descriptions
