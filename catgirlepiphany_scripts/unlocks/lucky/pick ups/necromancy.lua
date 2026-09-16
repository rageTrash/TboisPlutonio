local Mod = CAT_ASTROPHE
Mod.Card.NECROMANCY = {
	Name = {
		en_us = "Necromancy",
		
	},
	ID = Isaac.GetItemIdByName("Necromancy"),
	Unlock = function() return Mod:IsUnlock("Necromancy") end,
	Type = "Special",
}


local IsActive = false
Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, card, player, flags)
	IsActive = true
	Mod:Spawn(1000, EffectVariant.PURGATORY, 1, player.Position, Vector.Zero)
	Mod:Spawn(1000, EffectVariant.PURGATORY, 1, player.Position, Vector.Zero)
	Mod:Spawn(1000, EffectVariant.PURGATORY, 1, player.Position, Vector.Zero)
end, Mod.Card.NECROMANCY.ID)

Mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, function(_, ent)
	if not (IsActive and ent:IsEnemy() and ent:ToNPC() and ent:IsActiveEnemy() and ent:CanShutDoors() and Mod:CanTargetEntity(ent)) then return end
	if ent:IsBoss() then
		Mod:Spawn(1000, EffectVariant.HUNGRY_SOUL, 0, ent.Position, Vector.Zero)
		Mod:Spawn(1000, EffectVariant.HUNGRY_SOUL, 0, ent.Position, Vector.Zero)
		Mod:Spawn(1000, EffectVariant.HUNGRY_SOUL, 0, ent.Position, Vector.Zero)
	else
		Mod:Spawn(1000, EffectVariant.PURGATORY, 1, ent.Position, Vector.Zero)
	end
end)

Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	IsActive = false
end)