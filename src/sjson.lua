TraitTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/TraitText.en.sjson")
HelpTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/HelpText.en.sjson")
GUIBoonsVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Boons_VFX.sjson")

-- Order for TraitText SJSON
Order = {
	"Id",
	"InheritFrom",
	"DisplayName",
	"Description",
}

-- Order for HelpTextFile
HelpTextOrder = {
	"Id",
	"DisplayName",
}

-- Order for GUIBoonsVFXFile
IconOrder = {
	"Name",
	"InheritFrom",
	"FilePath",
}
