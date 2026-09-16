local Mod = CAT_ASTROPHE
Mod.Item.SCREEN_OF_DEATH = {
	Name = {
		["en_us"] = "Screen of Death",
		
	},
	ID = Isaac.GetItemIdByName("Screen of Death"),
	Unlock = function() return Epiphany ~= nil and Mod:IsUnlock("Screen of Death") end
}

local json = include("json")

local ignoreFlags = DamageFlag.DAMAGE_FAKE
Mod:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, -(1<<15), function(_, ent, amount, dmgFlag, src, coolFrame)
	local player = ent:ToPlayer()
	if not player or dmgFlag & ignoreFlags > 0 then return end
	if Mod.SaveHandler.StaticSave("Game Crash"):Get(false) then return end

	local red = player:GetHearts() + player:GetRottenHearts()
	local soul = player:GetSoulHearts()
	local bone = player:GetBoneHearts()

	if amount >= red + soul and bone == 0 or amount >= bone and red +soul == 0 then
		local save = json.decode(Mod:LoadData())
		save.StaticSave = save.StaticSave or {}
		save.StaticSave["Game Crash"] = true

		Mod:SaveData(json.encode(save))

		player:AddNullCostume(NullItemID.ID_NULL) -- goodbye gamers (crash the game)
	end
end)




Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()

end)