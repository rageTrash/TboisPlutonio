local Mod = CAT_ASTROPHE
Mod.Character.LUCKY = {
	Name = "Lucky"
	Type = Isaac.GetPlayerTypeByName("lucky"),
	--Setup = function(player)
	--	player:GetSprite():Load("gfx/characters/player_lucky.anm2", true)
	--end,
}
Mod.Character.LUCKY.NullItem = Isaac.GetNullItemIdByName("Luckys Revive")

local game = Mod.Game
local config = Isaac.GetItemConfig():GetCollectible(Mod.Character.LUCKY.NullItem)
CustomReviveLibThing.AddCustomRevive(config, CustomReviveLibThing.RevivePriority.HIGH)
--local corpe_hair = Isaac.GetCostumeIdByPath("")

local corpe_stats = {
	HEALTH_RED = 6,

	DAMAGE_MULTI = 1.25,
	DAMAGE_FLAT = 0.5,

	FIRERATE_MULTI = 0.8,
}

Mod:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, function()
	if not Epiphany or not Epiphany.API then return end

	Epiphany.API.AddCharacter({
	    charName = "LUCKY", 											-- Internal character name (REQUIRED)
	    charID = Mod.Character.LUCKY.Type,					-- Character ID (REQUIRED)
	    charStats = corpe_stats, 										-- Stat array
	    costume = "gfx/characters/player_luckys_body.anm2", 				-- Main costume (REQUIRED)
	    --extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_luckys_body_extra.anm2")}, 				-- Extra costume (e.g. Maggy's Hair)
	    menuGraphics = "gfx/epiphany_catgirl/lucky_menu.anm2", 						-- Character menu graphics (portrait, text) (REQUIRED)
	    coopMenuSprite = "gfx/epiphany_catgirl/lucky_coop.anm2", 						-- Co-op menu icon (REQUIRED)
	    --pocketItem = CollectibleType.COLLECTIBLE_SULFUR, 				-- Pocket active
	    --pocketItemPersistent = false, 								-- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
	    unlockChecker = function() return Mod:IsUnlock("Lucky") end, 					-- function that returns whether the character is unlocked. Defaults to always returning true.
	    --floorTutorial = "gfx/epiphany_catgitl/lucky_tutorial.anm2"
	})
end)


Mod:AddPriorityCallback(CustomReviveLibThing.Callbacks.PLAYER_REVIVE_CHECK, -99999999, function(_, player, itemconfig) return player:GetPlayerType() == Mod.Character.LUCKY.Type end, config)
Mod:AddCallback(CustomReviveLibThing.Callbacks.ON_PLAYER_REVIVE, function(_, player, itemconfig)

	local level = game:GetLevel()
	game:StartRoomTransition(level:GetPreviousRoomIndex(), 0, RoomTransitionAnim.FADE)
	player:SetFullHearts()
end, config)