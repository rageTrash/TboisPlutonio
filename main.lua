if not (CAT_ASTROPHE and REPENTOGON) then
    local mod = RegisterMod("Epiphany Cat-astrophe", 1)
    local font = Font()
    font:Load("font/pftempestasevencondensed.fnt")
    local missingMods = ((CAT_ASTROPHE and 0) or 1) + ((REPENTOGON and 0) or 2)
    local text = ({
        "Cat-astrophe",
        --"Epiphany",
        --"Cat-astrophe and Epiphany"
        "Repentogon",
        "Repentogon and Cat-astophe",
        --"Repentogon and Epiphany",
        --"Repentogon, Cat-astrophe and Epiphany",
    })[missingMods]


    mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
        font:DrawString("Cat-astrophe [Epiphany Edition] is missing", 50, 100, KColor(1, 1, 0.2, 1), 0, false)
        font:DrawString(text, 50, 110, KColor(1, 1, 0.2, 1), 0, false)
        font:DrawString("subcribe or install the missing mod(s) or unsubcribe this one", 50, 120, KColor(1, 1, 0.2, 1), 0, false)
        font:DrawString("Regards, Cat-astrophe dev :]", 50, 130, KColor(1, 1, 1, 1), 0, false)
    end)
    return
end


CAT_ASTROPHE:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, function()
    if not Epiphany then

        CAT_ASTROPHE:AddCallback(ModCallbacks.MC_POST_RENDER, function()
            CAT_ASTROPHE.TextFont:DrawString("Cat-astrophe [Epiphany Edition] is missing Epiphany", 50, 100, KColor(1, 1, 0.2, 1), 0, false)
            CAT_ASTROPHE.TextFont:DrawString("subcribe or install the missing mod(s) or unsubcribe this one", 50, 120, KColor(1, 1, 0.2, 1), 0, false)
            CAT_ASTROPHE.TextFont:DrawString("Regards, Cat-astrophe dev :]", 50, 130, KColor(1, 1, 1, 1), 0, false)
        end)
    end
end)

CAT_ASTROPHE.Include = function(rute) return require("a_scripts."..rute) end
for _, rute in ipairs({
	--"utils.custom_revive",
	--"characters._loader",
	--"unlocks._loader",
}) do
	CAT_ASTROPHE.Include(rute)
end