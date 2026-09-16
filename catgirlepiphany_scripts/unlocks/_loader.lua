local rute = "unlocks."
local loadItems= {
    "lucky.items.repressor",
}

for _, load in pairs(loadItems) do CAT_ASTROPHE.Include(rute .. load) end