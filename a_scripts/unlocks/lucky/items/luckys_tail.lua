local Mod = CAT_ASTROPHE
Mod.Item.LUCKYS_TAIL = {
	Name = {
		["en_us"] = "Lucky's Tail",
		
	},
	ID = Isaac.GetItemIdByName("Lucky's Tail"),
	Unlock = function() return Epiphany ~= nil and Mod:IsUnlock("Lucky's Tail") end
}


Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player, cacheflag)
	if not player:HasCollectible(Mod.Item.LUCKYS_TAIL.ID) then return end
	local mult = player:GetCollectibleNum(Mod.Item.LUCKYS_TAIL.ID)

	if (cacheflag & CacheFlag.CACHE_LUCK) >0 then
		player.Luck = player.Luck - (5 * mult)
	end
	if (cacheflag & CacheFlag.CACHE_DAMAGE) >0 then
		player.Damage = player.Damage + (player.Luck*-1)
	end
end)