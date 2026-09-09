local Mod = CAT_ASTROPHE
Mod.Card.ESSENCE_OF_LUCKY = {
    Name = {
        en_us = "Essence of Lucky",
        spa = "Esencia de Lucky"
    },
    ID = Isaac.GetItemIdByName("Essence of Lucky_cat-astrophe"),
    Unlock = function() return Mod:IsUnlock("Essence of Lucky") end,
    Type = "Rune",
}

local game = Mod.Game
local pool = game:GetItemPool()

local doublePickups = {
    {Var = 10, Sub = 5},
    {Var = 20, Sub = 4},
    {Var = 40, Sub = 2},
    {Var = 30, Sub = 3},
}


local ChampionDrop = {
    [0] = function(ent, pos) Mod:Spawn(5, 10, HeartSubType.HEART_FULL, pos, Vector.Zero, ent) end,
    [1] = function(ent, pos) Mod:Spawn(5, 90, BatterySubType.BATTERY_NORMAL, pos, Vector.Zero, ent) end,
    [2] = function(ent, pos) Mod:Spawn(5, 70, 0, pos, Vector.Zero, ent) end,
    [3] = function(ent)
        local pos = npc.Position
        local room = game:GetRoom()
        local rng = ent:GetDropRNG()
        for i=0, rng:RandomInt(3) do
            Mod:Spawn(5, 20, CoinSubType.COIN_PENNY, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        end
    end,
    [4] = function(ent, pos)
        local player = game:GetNearestPlayer(ent.Position)
        player:AddBlueFlies(3, ent.Position, nil)
    end,
    [5] = function(ent, pos) Mod:Spawn(5, 40, BombSubType.BOMB_NORMAL, pos, Vector.Zero, ent) end,
    [6] = function(ent, pos) Mod:Spawn(5, 10, HeartSubType.HEART_ETERNAL, pos, Vector.Zero, ent) end,
    [7] = function(ent, pos) Mod:Spawn(5, 30, KeySubType.KEY_NORMAL, pos, Vector.Zero, ent) end,
    [8] = function(ent, pos) Mod:Spawn(5, 60, 0, pos, Vector.Zero, ent) end,
    [9] = function(ent, pos) Mod:Spawn(5, 300, 0, pos, Vector.Zero, ent) end,
    [10] = function(ent, pos) Mod:Spawn(5, 10, 0, pos, Vector.Zero, ent) end,
    [11] = function(ent, pos) Mod:Spawn(5, 350, 0, pos, Vector.Zero, ent) end,
    [12] = function(ent, pos) Mod:Spawn(5, 10, HeartSubType.HEART_DOUBLEPACK, pos, Vector.Zero, ent) end,
    [13] = function(ent, pos) Mod:Spawn(5, 10, HeartSubType.HEART_HALF, pos, Vector.Zero, ent) end,
    [14] = function(ent, pos) Mod:Spawn(5, 300, pool:GetCard(ent:GetDropRNG(), false, true, true), pos, Vector.Zero, ent) end,
    [15] = function(ent)
        local pickup = doublePickups[ (ent:GetDropRNG():RandomInt(#doublePickups)+1) ]
        Mod:Spawn(5, pickup.Var, pickup.Sub, ent.Position, Vector.Zero, ent)
    end,
    [16] = function(ent) Mod:Spawn(5, 300, pool:GetCard(ent:GetDropRNG(), false, false, false), ent.Position, Vector.Zero, ent) end,
    [17] = function(ent)
        local player = game:GetNearestPlayer(ent.Position)
        player:AddBlueFlies(6, ent.Position, nil)
    end,
    [18] = function(ent, pos) Mod:Spawn(5, 70, 0, pos, Vector.Zero, ent) end,
    [19] = function(ent, pos) Mod:Spawn(5, 70, 0, pos, Vector.Zero, ent) end,
    [20] = function(ent, pos) Mod:Spawn(5, 10, HeartSubType.HEART_FULL, pos, Vector.Zero, ent) end,
    [21] = function(ent)
        local player = game:GetNearestPlayer(ent.Position)
        player:AddBlueFlies(10, ent.Position, nil)
    end,
    [22] = function(ent)
        local pos = npc.Position
        local room = game:GetRoom()
        local rng = ent:GetDropRNG()
        for i=0, rng:RandomInt(2)+1 do
            Mod:Spawn(5, 0, 2, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        end
    end,
    [23] = function() Isaac.GetPlayer():UseActiveItem( CollectibleType.COLLECTIBLE_NECRONOMICON, UseFlag.USE_NOANIM | UseFlag.USE_MIMIC, -1 ) end,
    [24] = function(ent, pos) Mod:Spawn(5, 10, 6, pos, Vector.Zero, ent) end,
    [25] = function(ent)
        local pos = npc.Position
        local room = game:GetRoom()

        Mod:Spawn(5, 10, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        Mod:Spawn(5, 20, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        Mod:Spawn(5, 30, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        Mod:Spawn(5, 40, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        Mod:Spawn(5, 70, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        Mod:Spawn(5, 300, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
        Mod:Spawn(5, 350, 0, room:FindFreePickupSpawnPosition(pos, 0, false), Vector.Zero, ent)
    end,
}


Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, card, player, flags)
    for _, ent in pairs(Isaac.GetRoomEntities()) do
        if ent:ToNPC() and ent:IsEnemy() and ent:IsActiveEnemy() and ent:CanShutDoors() and Mod:CanTargetEntity(ent) and not ent:IsBoss() then
            local npc = ent:ToNPC()
            if not npc:IsChampion() then
                npc:MakeChampion(npc.InitSeed, -1)
            end
            npc.HitPoints = npc.MaxHitPoints
        end
    end

end, Mod.Card.ESSENCE_OF_LUCKY.ID)


Mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, function(_, ent)
    local npc = ent:ToNPC()
    if not npc or not ChampionDrop[npc:GetChampionColorIdx()] then return end
    local pos = game:GetRoom():FindFreePickupSpawnPosition(npc.Position, 0, false)

    local fun = ChampionDrop[npc:GetChampionColorIdx()]
    if fun then fun(npc, pos) end
end)