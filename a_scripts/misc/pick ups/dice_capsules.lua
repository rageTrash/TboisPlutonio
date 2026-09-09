local Mod = CAT_ASTROPHE
Mod.Card.CAPSULE_D9 = {
	Name = {
		en_us = "Capsule D9",
	},
	ID = Isaac.GetCardIdByName("Capsule D9_cat-astrophe"),
	Unlock = function() return true end
}
Mod.Card.CAPSULE_ETERNAL_D9 = {
	Name = {
		en_us = "Capsule Eternal D9",
	},
	ID = Isaac.GetCardIdByName("Capsule Eternal D9_cat-astrophe"),
	Unlock = function() return true end
}
Mod.Card.CAPSULE_D_BROKEN = {
	Name = {
		en_us = "Capsule D Broken",
	},
	ID = Isaac.GetCardIdByName("Capsule D Broken_cat-astrophe"),
	Unlock = function() return true end
}


Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, card, player, flags)
	player:UseActiveItem(Mod.Item.ETERNAL_D9.ID, 1, -1)
	if player:GetCardRNG(card):RandomFloat() > 0.6 and flags & UseFlag.USE_MIMIC == 0 then
		player:AddCard(card)
	end
end, Mod.Card.CAPSULE_ETERNAL_D9.ID)

Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, card, player, flags)
	player:UseActiveItem(Mod.Item.D_BROKEN.ID, 1, -1)

end, Mod.Card.CAPSULE_D_BROKEN.ID)

Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, card, player, flags)
	player:UseActiveItem(Mod.Item.D9.ID, 1, -1)

end, Mod.Card.CAPSULE_D9.ID)