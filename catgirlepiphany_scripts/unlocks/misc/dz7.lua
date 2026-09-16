local Mod = CAT_ASTROPHE
Mod.Item.DZ7 = {
	Name = {
		["en_us"] = "Dz7",
		
	},
	ID = Isaac.GetItemIdByName("Dz7"),
	Unlock = function() return Mod:IsUnlock("Dz7") end
}


local game = Mod.Game

Mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, item, _, player, flags, slot)
	if game:GetRoom():IsClear() then return flags & UseFlag.USE_NOANIM == 0 end
	local roomDesc = game:GetLevel():GetCurrentRoomDesc()

	if roomDesc.Data == nil then return flags & UseFlag.USE_NOANIM == 0 end
	local spawnList = roomDesc.Data.Spawns
	if not spawnList or #spawnList == 0 then return flags & UseFlag.USE_NOANIM == 0 end

	local RNG = player:GetCollectibleRNG(item)

	for idx =0, #spawnList -1 do
		local spawn = spawnList:Get(idx)
		local entry = spawn:PickEntry(RNG:RandomFloat())
		local pos = Vector(spawn.X, spawn.Y)
		
		Mod:Spawn(entry.Type, entry.Variant, entry.SubType, pos, Vector.Zero)
		Mod:Spawn(1000, EffectVariant.POOF01, 0, pos, Vector.Zero)
	end

	return flags & UseFlag.USE_NOANIM == 0
end, Mod.Item.DZ7.ID)