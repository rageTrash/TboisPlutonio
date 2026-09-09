local Mod = CAT_ASTROPHE
Mod.Grid.LAPID = {
	Type = GridEntityType.GRID_ROCK_SS, --Type = GridEntityType.GRID_ROCK,
	Variant = 2500,
}
-- #insanity



local saveRoom = Mod.SaveHandler.Room
local game = Mod.Game
local pTools = Mod.PlayerTools



local Sprite = {
	Base = {
		[BackdropType.BASEMENT] = "_basement",
		[BackdropType.CELLAR] = "_cellar",
		[BackdropType.BURNT_BASEMENT] = "_burningbasement",
		[BackdropType.CAVES] = "_caves",
		[BackdropType.CATACOMBS] = "_catacombs",
		[BackdropType.FLOODED_CAVES] = "_drownedcaves",
		[BackdropType.DEPTHS] = "_depths",
		[BackdropType.NECROPOLIS] = "_depths",
		[BackdropType.DANK_DEPTHS] = "_depths",
		[BackdropType.WOMB] = "_womb",
		[BackdropType.UTERO] = "_utero",
		[BackdropType.SCARRED_WOMB] = "_scarredwomb",
		[BackdropType.BLUE_WOMB] = "_bluewomb",
		[BackdropType.SHEOL] = "_sheol",
		[BackdropType.CATHEDRAL] = "_cathedral",
		[BackdropType.DARKROOM] = "_sheol",
		[BackdropType.CHEST] = "_basement",
		[BackdropType.LIBRARY] = "_basement",
		[BackdropType.SHOP] = "_basement",
		[BackdropType.ISAAC] = "_basement",
		[BackdropType.BARREN] = "_basement",
		[BackdropType.SECRET] = "_secretroom",
		[BackdropType.DICE] = "_basement",
		[BackdropType.ARCADE] = "_basement",
		[BackdropType.ERROR_ROOM] = "_basement",
		[BackdropType.BLUE_WOMB_PASS] = "_bluewomb",
		[BackdropType.GREED_SHOP] = "_basement",
		[BackdropType.SACRIFICE] = "_depths",
		[BackdropType.DOWNPOUR] = "_downpour",
		[BackdropType.MINES] = "_secretroom",
		[BackdropType.MAUSOLEUM] = "_mausoleum",
		[BackdropType.CORPSE] = "_corpse",
		[BackdropType.PLANETARIUM] = "_cathedral",
		[BackdropType.DOWNPOUR_ENTRANCE] = "_downpour",
		[BackdropType.MINES_ENTRANCE] = "_secretroom",
		[BackdropType.MAUSOLEUM_ENTRANCE] = "_mausoleum",
		[BackdropType.CORPSE_ENTRANCE] = "_corpseentrance",
		[BackdropType.MAUSOLEUM2] = "_mausoleum",
		[BackdropType.MAUSOLEUM3] = "_mausoleum",
		[BackdropType.MAUSOLEUM4] = "_mausoleum",
		[BackdropType.CORPSE2] = "_corpse2",
		[BackdropType.CORPSE3] = "_corpse3",
		[BackdropType.DROSS] = "_dross",
		[BackdropType.ASHPIT] = "_ashpit",
		[BackdropType.GEHENNA] = "_gehenna",
		[BackdropType.MORTIS] = "_mortis",
		[BackdropType.MINES_SHAFT] = "_secretroom",
		[BackdropType.ASHPIT_SHAFT] = "_ashpit",
		[BackdropType.DARK_CLOSET] = "_depths",
	},
	FiendFolio = { -- haha funny rocks
		--- idk
		[BackdropType.BLUE_WOMB_PASS] = "_bluewomb",
		[BackdropType.PLANETARIUM] = "_cathedral",
		[BackdropType.MAUSOLEUM_ENTRANCE] = "_mausoleum",
		[BackdropType.CORPSE_ENTRANCE] = "_corpseentrance",

		rocks_basement = "_basement",
		rocks_cellar = "_cellar",
		rocks_burningbasement = "_burningbasement",
		rocks_caves = "_caves",
		rocks_catacombs = "_catacombs",
		rocks_drownedcaves = "_drownedcaves",
		rocks_depths_custom = "_depths",
		rocks_necropolis = "_necropolis",
		rocks_dankdepths = "_dankdepths",
		rocks_womb = "_womb",
		rocks_utero = "_utero",
		rocks_scarredwomb = "_scarredwomb",
		rocks_bluewomb = "_bluewomb",
		rocks_sheol = "_sheol",
		rocks_cathedral = "_cathedral",
		rocks_darkroom = "_darkroom",
		rocks_chest = "_chest",
		rocks_library = "_library",
		rocks_shop = "_shop",
		rocks_secret = "_secret",
		rocks_secretroom = "_mines",
		rocks_dice = "_dice",
		rocks_arcade = "_arcade",
		["rocks_error-1"] = "_error-1",
		rocks_depths = "_sacrifice",
		rocks_downpour = "_downpour",
		rocks_mausoleum = "_mausoleum",
		rocks_corpse = "_corpse",
		rocks_downpour_entrance = "_downpour_dryied",
		rocks_mausoleum = "_mausoleum",
		rocks_mausoleumb = "_mausoleumb",
		rocks_mausoleum = "_mausoleum",
		rocks_corpse2 = "_corpse2",
		rocks_corpse3 = "_corpse3",
		rocks_dross = "_dross",
		rocks_ashpit = "_ashpit",
		rocks_gehenna = "_gehenna",

		rocks_d12 = "_d12",
		rocks_ed12 = "_ed12",
		hive_rocks = "_hive",
		smoky_rocks = "_smoky",
		rocks_pipes = "_pipes",
		rocks_primitive = "_primitive",
		rocks_trash = "_trash",
		rock_challenge_placeholderrecolor = "_challenge",
		--rocks_crawlspace = "_crawlspace",
		--rocks_crawlspace_luscious = "_crawlspace_luscious",
		--rocks_crawlspace_ossuary = "_crawlspace_ossuary",
		--rocks_crawlspace_fortress = "_crawlspace_fortress",
		--rocks_crawlspace_insulation = "_crawlspace_insulation",
		rocks_peepee = "_drossPiss",
		morbus_rocks = "_morbus",

		realShit = "_realshit",
	},
	LastJudgement = {
		rocks_mortis = "_mortis",
		rocks_morgueis = "_morgueis",
		rocks_moistis = "_moistis",

		rocks_mortis_ff = "_mortis",
		rocks_morgueis_ff = "_morgueis",
		rocks_moistis_ff = "_moistis",
	},
	Revelation = {
		"_glacier",
		"_tomb",
		"_vestige",
	}
}



local function setSprite(grid)
	local room = game:GetRoom()
	local sprite = grid:GetSprite()
	local file = "gfx/grid/lapid"

	if StageAPI then
		if LastJudgement and LastJudgement.STAGE.Mortis:IsStage() then

			if FiendFolio then
				file = "gfx/grid/fiend_folio/lapid"
			end
			file = file .. Sprite.LastJudgement[( LastJudgement:GetMortisRocks():gsub("gfx/grid/", ""):gsub(".png", "") )]

		elseif REVEL and REVEL.STAGE and (
			REVEL.STAGE.Glacier and REVEL.STAGE.Glacier:IsStage() or
			REVEL.STAGE.Tomb and REVEL.STAGE.Tomb:IsStage() or
			REVEL.STAGE.Vestige and REVEL.STAGE.Vestige:IsStage()) then

			local sprite = 0
			if REVEL.STAGE.Glacier and REVEL.STAGE.Glacier:IsStage() then sprite = 1
			elseif REVEL.STAGE.Tomb and REVEL.STAGE.Tomb:IsStage() then sprite = 2
			elseif REVEL.STAGE.Vestige and REVEL.STAGE.Vestige:IsStage() then sprite = 3
			end

			file = file .. ( Sprite.Revelation[ sprite ] or "_basement" )

		elseif FiendFolio then

			file = "gfx/grid/fiend_folio/lapid"

			if FiendFolio.TheLab and FiendFolio.TheLab:IsStage() then
				file = file .. Sprite.FiendFolio[ "realShit" ]
			elseif FiendFolio.MorbusReal and FiendFolio.MorbusReal:IsStage() then
				file = file .. Sprite.FiendFolio[ "realShit" ]
			elseif FiendFolio.StonyLevel and FiendFolio.StonyLevel:IsStage() then
				file = file .. Sprite.FiendFolio[ "realShit" ]
			else
				local RoomSeed = room:GetSpawnSeed() * 10
				if room:IsMirrorWorld() then RoomSeed = RoomSeed+1 end --- kinda copy from fiend folio

				if FiendFolio.d12ed_Rooms[RoomSeed] and FiendFolio.d12ed_Rooms[RoomSeed].Type then
					local type = FiendFolio.d12ed_Rooms[RoomSeed].Type
					if type == 2 then
						file = file .. Sprite.FiendFolio[ "rocks_ed12" ]
					else
						file = file .. Sprite.FiendFolio[ "rocks_d12" ]
					end
				else
					local data = FiendFolio:getCurrentRoomGfx()

					if type(data) ~= "function" and data.Rocks then
						file = file .. ( Sprite.FiendFolio[( data.Rocks:gsub("gfx/grid/", ""):gsub(".png", "") )] or "_basement" )
					else
						file = file .. ( Sprite.FiendFolio[ room:GetBackdropType() ] or "_basement" )
					end
				end
			end
		else
			file = file .. ( Sprite.Base[ room:GetBackdropType() ] or "_basement" )
		end
	else
		file = file .. ( Sprite.Base[ room:GetBackdropType() ] or "_basement" )
	end

	sprite:ReplaceSpritesheet(0, file .. ".png")
	--sprite:Play("superspecial", true)
	sprite:LoadGraphics()
end




local extraDropTable = {
	function(pos, RNG)
		if RNG:RandomInt(2) == 1 then

			if pTools.AllPlayersArePlayerType(PlayerType.PLAYER_BLUEBABY_B) or pTools.IsPlayerPresent(PlayerType.PLAYER_BLUEBABY_B) and RNG:RandomInt(5) == 1 then

				if RNG:RandomInt(4) == 1 then
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 1, pos, Mod:RandomVector(nil,nil, RNG) *3)
				else
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 0, pos, Mod:RandomVector(nil,nil, RNG) *3)
				end
			else
				Mod:Spawn(5, PickupVariant.PICKUP_BOMB, 0, pos, Mod:RandomVector(nil,nil, RNG) *3)
			end
		else
			Mod:Spawn(5, PickupVariant.PICKUP_KEY, 0, pos, Mod:RandomVector(nil,nil, RNG) *3)
		end
	end,
	function(pos, RNG)
		if RNG:RandomInt(2) == 1 then
			Mod:Spawn(5, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, pos, Mod:RandomVector(nil,nil, RNG) *3)

		elseif RNG:RandomInt(2) == 1 then
			if pTools.AllPlayersArePlayerType(PlayerType.PLAYER_BLUEBABY_B) or pTools.IsPlayerPresent(PlayerType.PLAYER_BLUEBABY_B) and RNG:RandomInt(5) == 1 then
				if RNG:RandomInt(4) == 1 then
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 1, pos, Mod:RandomVector(nil,nil, RNG) *3)
				else
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 0, pos, Mod:RandomVector(nil,nil, RNG) *3)
				end
			else
				Mod:Spawn(5, PickupVariant.PICKUP_BOMB, 0, pos, Mod:RandomVector(nil,nil, RNG) *3)
			end
		else
			Mod:Spawn(5, PickupVariant.PICKUP_KEY, 0, pos, Mod:RandomVector(nil,nil, RNG) *3)
		end
	end,
	function(pos, RNG)
		Mod:Spawn(5, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, pos, Mod:RandomVector(nil,nil, RNG) *3)
	end,
}


local function extraDrop(pos, RNG, dropType)
	pTools.AnyPlayerHasTrinket()
end

local function dropHearts(RNG, amount)

	for _=1, (amount or 1) do
		if RNG:RandomInt(5) == 1 then
			Mod:Spawn(5, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BONE, pos, Mod:RandomVector(nil,nil, RNG) *3)
		else
			Mod:Spawn(5, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, pos, Mod:RandomVector(nil,nil, RNG) *3)
		end
	end
end

local DropRNG = RNG()
local function lapidDrops(grid)
	DropRNG:SetSeed(grid.Desc.SpawnSeed, 35)

	local drop = DropRNG:RandomInt(100)+1
	local pos = grid.Position

	if drop <= 25 then

		for _=1 ,DropRNG:RandomInt(3)+1 do

			if DropRNG:RandomInt(2) == 1 then

				if pTools.AllPlayersArePlayerType(PlayerType.PLAYER_BLUEBABY_B) or pTools.IsPlayerPresent(PlayerType.PLAYER_BLUEBABY_B) and DropRNG:RandomInt(5) == 1 then

					if DropRNG:RandomInt(4) == 1 then
						Mod:Spawn(5, PickupVariant.PICKUP_POOP, 1, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
					else
						Mod:Spawn(5, PickupVariant.PICKUP_POOP, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
					end
				else
					Mod:Spawn(5, PickupVariant.PICKUP_BOMB, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
				end
			else
				Mod:Spawn(5, PickupVariant.PICKUP_KEY, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
			end

		end

		extraDrop(pos, DropRNG, 1)

	elseif drop <= 55 then
		dropHearts(DropRNG, 1)

		if DropRNG:RandomInt(10) == 1 then
			if pTools.AllPlayersArePlayerType(PlayerType.PLAYER_BLUEBABY_B) or pTools.IsPlayerPresent(PlayerType.PLAYER_BLUEBABY_B) and DropRNG:RandomInt(5) == 1 then
				if DropRNG:RandomInt(4) == 1 then
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 1, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
				else
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
				end
			else
				Mod:Spawn(5, PickupVariant.PICKUP_BOMB, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
			end
		end

		if DropRNG:RandomInt(10) == 1 then
			Mod:Spawn(5, PickupVariant.PICKUP_KEY, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
		end

		extraDrop(pos, DropRNG, 1)

	elseif drop <= 80 then
		dropHearts(DropRNG, 2)

		if DropRNG:RandomInt(5) == 1 then
			if pTools.AllPlayersArePlayerType(PlayerType.PLAYER_BLUEBABY_B) or pTools.IsPlayerPresent(PlayerType.PLAYER_BLUEBABY_B) and DropRNG:RandomInt(5) == 1 then
				if DropRNG:RandomInt(4) == 1 then
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 1, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
				else
					Mod:Spawn(5, PickupVariant.PICKUP_POOP, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
				end
			else
				Mod:Spawn(5, PickupVariant.PICKUP_BOMB, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
			end
		end

		if DropRNG:RandomInt(5) == 1 then
			Mod:Spawn(5, PickupVariant.PICKUP_KEY, 0, pos, Mod:RandomVector(nil,nil, DropRNG) *3)
		end

		extraDrop(pos, DropRNG, 1)

	elseif drop <= 97 then

		local item, isEmpty = Mod.CustomPool:GetTrinket("Lapid pool", DropRNG, true)
		if isEmpty then
			dropHearts(DropRNG, DropRNG:RandomInt(2)+1) -- 1-2 hearts
			
			extraDrop(pos, DropRNG, 2)
		else
			Mod:Spawn(5, 350, item, pos, Vector.Zero)
		end

	else
		local item, isEmpty = Mod.CustomPool:GetItem("Lapid pool", DropRNG, true)
		if isEmpty then
			dropHearts(DropRNG, DropRNG:RandomInt(3)+2) -- 2-4 hearts

			extraDrop(pos, DropRNG, 2)
		else
			Mod:Spawn(5, 100, item, pos, Vector.Zero)
		end
	end

	for _=1, Mod:RandomInt(4, 7, DropRNG) do
		if DropRNG:RandomInt(5) == 1 then
			Mod:Spawn(1000, EffectVariant.HUNGRY_SOUL, 0, ent.Position, Vector.Zero)
		else
			Mod:Spawn(1000, EffectVariant.PURGATORY, 1, ent.Position, Vector.Zero)
		end
	end
end


local function tryFindLapid()
	local room = game:GetRoom()

	for idx =0, room:GetGridSize()-1 do
		local grid = room:GetGridEntity(gridIdx)
		if grid and grid:GetType() == Mod.Grid.LAPID.Type and grid:GetVariant() == Mod.Grid.LAPID.Variant and grid.State < 3 then
			local pos = grid.Position
			saveRoom("Has Lapid"):Set({X = pos.X, Y = pos.Y})
			return
		end
	end

	saveRoom("Has Lapid"):Set(nil)
end


local function makeToLapid(grid)
	if grid:ToRock() then
		grid:SetType(Mod.Grid.LAPID.Type)
		grid:SetVariant(Mod.Grid.LAPID.Variant)
		local pos = grid.Position

		setSprite(grid)

		saveRoom("Has Lapid"):Set({X = pos.X, Y = pos.Y})
	end
end

local replaceChance = {
	[GridEntityType.GRID_ROCKT] = 0.1,
	[GridEntityType.GRID_ROCK] = 0.01
}


local GenerationRNG = RNG()
if Mod.Repentogon then
	Mod:AddCallback(ModCallbacks.MC_PRE_ROOM_GRID_ENTITY_SPAWN, function(_, t, v, varData, gridIdx, seed)
		local room = game:GetRoom()
		if not room:IsFirstVisit() or saveRoom("Has Lapid"):Get(nil) ~= nil then return end

		local grid = room:GetGridEntity(gridIdx)
		GenerationRNG:SetSeed(seed, 35)
		local makeLapid = false

		if replaceChance[t] and GenerationRNG:RandomFloat() <= replaceChance[t] then
			makeLapid = true
		end

		if makeLapid then
			local pos = room:GetGridPosition(gridIdx)
			saveRoom("Has Lapid"):Set(true)

			return {Mod.Grid.LAPID.Type, Mod.Grid.LAPID.Variant, 0, seed}
		end
	end)

	Mod:AddCallback(ModCallbacks.MC_POST_GRID_ROCK_DESTROY, function(_, gridRock, gridType, immediate)
		if gridRock:GetType() == Mod.Grid.LAPID.Type and gridRock:GetVariant() == Mod.Grid.LAPID.Variant and saveRoom("Has Lapid"):Get(nil) ~= nil then
			lapidDrops(gridRock)
			saveRoom("Has Lapid"):Set(nil)
		end
	end)
else
	Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
		local room = game:GetRoom()
		if not room:IsFirstVisit() then return end

		if room:GetType() == RoomType.ROOM_DUNGEON then return end

		for idx =0, room:GetGridSize()-1 do
			local grid = room:GetGridEntity(idx)
			if grid:ToRock() then
				local t = grid:GetType()
				if replaceChance[t] then
					GenerationRNG:SetSeed(grid.Desc.SpawnSeed, 35)

					if GenerationRNG:RandomFloat() <= replaceChance[t] then
						makeToLapid(grid)
						break
					end
				end
			end
		end
	end)



	Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
		local lapidData = saveRoom("Has Lapid"):Get(nil)
		if type(lapidData) == "nil" then return end

		local room = game:GetRoom()
		local pos = Vector(lapidData.X, lapidData.Y)
		local grid = room:GetGridEntityFromPos(pos)

		if (not grid and grid:GetType() == Mod.Grid.LAPID.Type and grid:GetVariant() == Mod.Grid.LAPID.Variant) then
			saveRoom("Has Lapid"):Set(nil)
			tryFindLapid()
			return
		end

		if grid.State == 2 then
			lapidDrops(grid)
			saveRoom("Has Lapid"):Set(nil)
		end
	end)
end




CustomCommands:AddCommand(
	"CAT_ASTROPHE",
	"TestLapid",
	{},
	function()
		local pos = Isaac.GetFreeNearPosition(game:GetRoom():GetCenterPos(), 0)
		local grid = Isaac.GridSpawn(GridEntityType.GRID_ROCK, 0, pos, true)
		makeToLapid(grid)
	end
)