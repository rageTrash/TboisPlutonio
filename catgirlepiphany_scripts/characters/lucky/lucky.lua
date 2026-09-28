local Mod = CAT_ASTROPHE
Mod.Character.LUCKY = {
    Name = "Lucky",
    Type = Isaac.GetPlayerTypeByName("lucky"),
    --Setup = function(player)
    --    player:GetSprite():Load("gfx/characters/player_lucky.anm2", true)
    --end,
}
Mod.Character.LUCKY.NullItem = Isaac.GetNullItemIdByName("Luckys Revive")

local game = Mod.Game
local config = Isaac.GetItemConfig():GetCollectible(Mod.Character.LUCKY.NullItem)
CustomReviveLibThing.AddCustomRevive(config, CustomReviveLibThing.RevivePriority.HIGH)
--local corpe_hair = Isaac.GetCostumeIdByPath("")
local LIVESCOLOR = KColor(1, 1, 1, 1)



local LuckyNonoItems = {
    [CollectibleType.COLLECTIBLE_1UP] = true,
    [CollectibleType.COLLECTIBLE_DEAD_CAT] = true,
    [CollectibleType.COLLECTIBLE_INNER_CHILD] = true,
    [CollectibleType.COLLECTIBLE_GUPPYS_COLLAR] = true,
    [CollectibleType.COLLECTIBLE_LAZARUS_RAGS] = true,
    [CollectibleType.COLLECTIBLE_ANKH] = true,
    [CollectibleType.COLLECTIBLE_JUDAS_SHADOW] = true,
}
local LuckyNonoTrinkets = {
    [TrinketType.TRINKET_BROKEN_ANKH] = true,
    [TrinketType.TRINKET_MISSING_POSTER] = true,
}
local LuckyNonoConsumables = {
    Cards = {
        [Card.CARD_SOUL_LAZARUS] = true
    },
    PillsEffect = {},
}

function Mod.Character.LUCKY.BlacklistedItems(...)
    for idx, itemId in ipairs({...}) do
        if type(itemId) ~="number" then
            error("Argument #"..idx.." is not a number", 2)
            return
        end
        LuckyNonoItems[itemId] = true
    end
end

function Mod.Character.LUCKY.BlacklistedTrinkets(...)
    for idx, trinketId in ipairs({...}) do
        if type(trinketId) ~="number" then
            error("Argument #"..idx.." is not a number", 2)
            return
        end
        LuckyNonoTrinkets[trinketId] = true
    end
end

function Mod.Character.LUCKY.BlacklistedConsumables(...)
    for idx, data in ipairs({...}) do
        if type(data) ~="table" then
            error("Argument #"..idx.." is not a table", 2)
            return
        end
        if type(data.Var) ~="number" then
            error("Key [Var] in argument #"..idx.." is not a number", 2)
            return
        end
        if type(data.Sub) ~="number" then
            error("Key [Sub] in argument #"..idx.." is not a number", 2)
            return
        end
        if data.Var == 300 then
            LuckyNonoConsumables.Cards[data.Sub] = true
        elseif data.Var == 70 then
            LuckyNonoConsumables.PillsEffect[data.Sub] = true
        else
            error("Key [Var] in argument #"..idx.." is a valid consumable variant", 2)
            return
        end
        
    end
end



Mod:AddPriorityCallback(ModCallbacks.MC_POST_PICKUP_INIT, 2^32, function(_, pickup)
    local var = pickup.Variant
    local sub = pickup.SubType

    if var == 100 then
        if LuckyNonoItems[sub] then
            pickup:Morph(5, 100, CollectibleType.COLLECTIBLE_BREAKFAST)
        end
    elseif var == 350 then
        if LuckyNonoTrinkets[sub] then
            pickup:Morph(5, 350, 0)
        end
    elseif var == 300 then
        if LuckyNonoConsumables.Cards[sub] then
            pickup:Morph(5, 300, 0)
        end
    end
end)

local antiinfiniteblucle = 0
Mod:AddPriorityCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, 2^32, function(_, itemId, itemPool, decrease, seed)
    if antiinfiniteblucle >100 then
        antiinfiniteblucle = 0
        return CollectibleType.COLLECTIBLE_BREAKFAST
    end
    if LuckyNonoItems[itemId] then
        antiinfiniteblucle = antiinfiniteblucle +1
        game:GetItemPool():RemoveCollectible(itemId)
        return Mod:GetRandomCollectible(itemPool, decrease, seed, CollectibleType.COLLECTIBLE_BREAKFAST)
    end
    antiinfiniteblucle = 0
end)

Mod:AddPriorityCallback(ModCallbacks.MC_GET_CARD, 2^32, function(_, rng, cardId, includePlaying, includeRunes, runesOnly)
    if antiinfiniteblucle >100 then
        antiinfiniteblucle = 0
        return Card.CARD_FOOL
    end
    if LuckyNonoConsumables.Cards[cardId] then
        antiinfiniteblucle = antiinfiniteblucle +1
        return game:GetItemPool():GetCard(rng:Next(), includePlaying, includeRunes, runesOnly)
    end
    antiinfiniteblucle = 0
end)

Mod:AddPriorityCallback(ModCallbacks.MC_GET_PILL_EFFECT, 2^32, function(_, pillEffect, pillColor)
    if LuckyNonoConsumables.PillsEffect[pillEffect] then
        return PillEffect.PILLEFFECT_BAD_GAS
    end
end)

Mod:AddPriorityCallback(ModCallbacks.MC_GET_TRINKET, 2^32, function(_, trinketId, rng)
    if antiinfiniteblucle >100 then
        antiinfiniteblucle = 0
        return 1
    end
    if LuckyNonoTrinkets[trinketId] then
        antiinfiniteblucle = antiinfiniteblucle +1
        game:GetItemPool():RemoveTrinket(trinketId)
        return game:GetItemPool():GetTrinket()
    end
    antiinfiniteblucle = 0
end)



local corpe_stats = {
    HEALTH_RED = 6,

    DAMAGE_MULTI = 1.25,
    DAMAGE_FLAT = 0.5,

    FIRERATE_MULTI = 0.8,
}

Mod:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, function()
    if CAT_ASTROPHE.DEBUG or not Epiphany or not Epiphany.API then return end

    Epiphany.API.AddCharacter({
        charName = "LUCKY",                                             -- Internal character name (REQUIRED)
        charID = Mod.Character.LUCKY.Type,                    -- Character ID (REQUIRED)
        charStats = corpe_stats,                                         -- Stat array
        costume = "gfx/characters/player_luckys_body.anm2",                 -- Main costume (REQUIRED)
        --extraCostume = {Isaac.GetCostumeIdByPath("gfx/characters/character_luckys_body_extra.anm2")},                 -- Extra costume (e.g. Maggy's Hair)
        menuGraphics = "gfx/epiphany_catgirl/lucky_menu.anm2",                         -- Character menu graphics (portrait, text) (REQUIRED)
        coopMenuSprite = "gfx/epiphany_catgirl/lucky_coop.anm2",                         -- Co-op menu icon (REQUIRED)
        --pocketItem = CollectibleType.COLLECTIBLE_SULFUR,                 -- Pocket active
        --pocketItemPersistent = false,                                 -- Should the pocket active always be re-given when not present? (false is vanilla behaviour)
        unlockChecker = function() return Mod:IsUnlock("Lucky") end,                     -- function that returns whether the character is unlocked. Defaults to always returning true.
        --floorTutorial = "gfx/epiphany_catgitl/lucky_tutorial.anm2"
    })
end)


Mod:AddPriorityCallback(CustomReviveLibThing.Callbacks.PLAYER_REVIVE_CHECK, -99999999, function(_, player, itemconfig) return player:GetPlayerType() == Mod.Character.LUCKY.Type end, config)
Mod:AddCallback(CustomReviveLibThing.Callbacks.ON_PLAYER_REVIVE, function(_, player, itemconfig)

    local level = game:GetLevel()
    game:StartRoomTransition(level:GetPreviousRoomIndex(), 0, RoomTransitionAnim.FADE)
    player:SetFullHearts()
end, config)


local function renderLuckyLifes(playerHud)
    local playerIdx = playerHud:GetIndex()
    local player = playerHud:GetPlayer()

    local renderScrolloffset = game:GetRoom():GetRenderSurfaceTopLeft()
    local bottomRight = renderScrolloffset * 2 + Vector(442,286)
    local hudOffset = Options.HUDOffset * 10

    local num = player:GetEffects():GetNullEffectNum(Mod.Character.LUCKY.NullItem)
    local totalHealth = math.min(math.ceil(player:GetMaxHearts() /2) + math.ceil(player:GetSoulHearts() /2) + player:GetBoneHearts() + player:GetBrokenHearts(), 5)
    local x = -2 + 12 * totalHealth
    local y = -8 + 8 * 0--math.max(0, math.ceil(totalHealth/2) -1) /2
    local xOffset, yOffset = 0, 0


    if playerIdx == 0 then
        xOffset = 48 + hudOffset * 2
        yOffset = 12 + math.floor(hudOffset * 2.4 + 0.5) / 2

    elseif playerIdx == 1 then
        xOffset = bottomRight.X - 111 - math.floor(hudOffset * 2.4 + 0.5)
        yOffset = 12 + math.floor(hudOffset * 2.4 + 0.5) / 2
        
    elseif playerIdx == 2 then
        xOffset = 58 + math.floor(hudOffset * 2.2 + 0.5)
        yOffset = bottomRight.Y - 27 - math.floor(hudOffset * 1.2 + 0.5) / 2
        
    elseif playerIdx == 3 then
        xOffset = bottomRight.X - 119 - math.floor(hudOffset * 1.6 + 0.5)
        yOffset = bottomRight.Y - 27 - math.floor(hudOffset * 1.2 + 0.5) / 2
    end


    local str = "-"..num
    if playerIdx % 2 == 0 then
        str = "x"..str
    else
        str = str.."x"
    end

    Mod.TextFont:DrawStringScaled(str, xOffset + x, yOffset + y, 1, 1, LIVESCOLOR, 0, true)
end

Mod:AddPriorityCallback(ModCallbacks.MC_HUD_RENDER, 2^32, function()
    if game:GetLevel():GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN > 0 then return end
    local hud = game:GetHUD()

    for i=0, 7 do
        local playerHud = hud:GetPlayerHUD(i)
        renderLuckyLifes(playerHud)
    end

end)

Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
    if player:GetPlayerType() ~= Mod.Character.LUCKY.Type then return end

    player:GetEffects():AddNullEffect(Mod.Character.LUCKY.NullItem, false, 1)
end)


Mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, -200, function(_, player, flag)
    if player:GetPlayerType() ~= Mod.Character.LUCKY.Type then return end
    if flag & CacheFlag.CACHE_DAMAGE > 0 then
        player.Damage = player.Damage + 0.5
    end
    
    --[[
    if flag & CacheFlag.CACHE_FIREDELAY > 0 then
        local num = player:GetEffects():GetNullEffectNum(Mod.Character.LUCKY.NullItem)
        num = 
        player.MaxFireDelay = Mod.PlayerTools.AddTears(player,  * MultiplierHandler:GetPlayerTearsMult(player) )
    end]]
end)

Mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, 200, function(_, player, flag)
    if player:GetPlayerType() ~= Mod.Character.LUCKY.Type then return end
    local num = player:GetEffects():GetNullEffectNum(Mod.Character.LUCKY.NullItem)

    if flag & CacheFlag.CACHE_DAMAGE > 0 then
        player.Damage = player.Damage * (1.25 + 0.05 * (num -1))
    end
    if flag & CacheFlag.CACHE_FIREDELAY > 0 then
        player.MaxFireDelay = Mod.PlayerTools.ApplyTearsMultiplier(player, 0.8)
    end
    
end)

