local Mod = CAT_ASTROPHE
Mod.Item.WHITE_HAND = {
	Name = {
		["en_us"] = "White Hand",
		
	},
	ID = Isaac.GetItemIdByName("White Hand"),
	Unlock = function() return Epiphany ~= nil and Mod:IsUnlock("White Hand") end
}


local State = {
	EMPTY = 0,
	GRABING = 1,
}

local WHITE_HAND_GRAB_TIME = 300
local GRAB_RANGE = 20

Mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, hand)
	if hand.State == State.GRABING then return end

	for _, ent in pairs(Isaac.FindInRadius(hand.Position, GRAB_RANGE, EntityPartition.ENEMY)) do
		if ent:Exists() and not ent:IsDead() and ent:CollidesWithGrid() then
			if Mod:GetEntityData(ent, "White Hand", nil) then
				Mod:SetEntityData(ent, "White Hand", Mod:GetEntityData(ent, "White Hand", nil) *2 )
			else
				Mod:SetEntityData(ent, "White Hand", WHITE_HAND_GRAB_TIME )
			end
			return
		end
	end

	for _, ent in pairs(Isaac.FindInRadius(hand.Position, GRAB_RANGE, EntityPartition.PLAYER)) do
		local player = ent:ToPlayer()
		if player and player:Exists() and not player:IsDead() and not player.CanFly then
			if Mod:GetEntityData(ent, "White Hand", nil) then
				Mod:SetEntityData(ent, "White Hand", Mod:GetEntityData(ent, "White Hand", nil) *2 )
			else
				Mod:SetEntityData(ent, "White Hand", WHITE_HAND_GRAB_TIME )
			end
			return
		end
	end
end, handHerePlease)