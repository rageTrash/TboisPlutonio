local Mod = CAT_ASTROPHE
Mod.Item.REPRESSOR = {
	Name = {
		["en_us"] = "Repressor",
		
	},
	ID = Isaac.GetItemIdByName("Repressor"),
	Unlock = function() return Mod:IsUnlock("Repressor") end
}


Mod:AddPriorityCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_ACTIVE_ITEM, (2^32), function(_, player, slot, offset, alpha, scale)
	if player:GetActiveItem(slot) == Mod.Item.REPRESSOR.ID then

		return {
			CropOffset=Vector(64 + 32* Mod:RandomInt(0, 5), 0)
		}
	end
end)