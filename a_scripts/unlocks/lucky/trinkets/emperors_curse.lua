local Mod = CAT_ASTROPHE
Mod.Trinket.EMPERORS_CURSE = {
	Name = {
		["en_us"] = "Emperors Curse",
		
	},
	ID = Isaac.GetItemIdByName("Emperors Curse"),
	Unlock = function() return Epiphany ~= nil and Mod:IsUnlock("Emperors Curse") end,
}