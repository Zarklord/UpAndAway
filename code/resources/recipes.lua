--[[
GLOBAL.TECH.NONE.FABLE = 0
GLOBAL.TECH.FABLE_1 = {FABLE = 3}

for k,v in pairs(GLOBAL.TUNING.PROTOTYPER_TREES) do 
    GLOBAL.TUNING.PROTOTYPER_TREES[k].FABLE = 0
	GLOBAL.TUNING.PROTOTYPER_TREES.FABLE= {SCIENCE = 0,MAGIC = 0,ANCIENT = 0,FABLE=1}
end	
]]--


wickerrequire "plugins.addtechbranch"


TheMod:AddTechBranch("FABLE", 3)
TheMod:AddPrototyperTree("RESEARCH_LECTERN", {FABLE = 2}, STRINGS.UPUI.CRAFTING.NEEDRESEARCHLECTERN)


local RECIPETABS = _G.RECIPETABS
local TECH = _G.TECH


--These are the inventory icons for recipe ingredients.
local cloud_cotton = Ingredient("cloud_cotton", 1)
cloud_cotton.atlas = "images/inventoryimages/cloud_cotton.xml"

local crystal_fragment_relic = Ingredient("crystal_fragment_relic", 1)
crystal_fragment_relic.atlas = "images/inventoryimages/crystal_fragment_relic.xml"

--These are the recipes and the icons for the recipe output.
local cotton_vest = Recipe("cotton_vest", { Ingredient("silk", 4), Ingredient("cloud_cotton", 4, "images/inventoryimages/cloud_cotton.xml") }, RECIPETABS.DRESS, TECH.FABLE_1)
cotton_vest.atlas = "images/inventoryimages/cotton_vest.xml"

local cotton_hat = Recipe("cotton_hat", { Ingredient("silk", 2), Ingredient("cloud_cotton", 6, "images/inventoryimages/cloud_cotton.xml") }, RECIPETABS.DRESS, TECH.FABLE_1)
cotton_hat.atlas = "images/inventoryimages/cotton_hat.xml"

local mushroom_hat = Recipe("mushroom_hat", { Ingredient("red_cap", 3), Ingredient("blue_cap", 3), Ingredient("green_cap", 3) }, RECIPETABS.DRESS, TECH.FABLE_1)
mushroom_hat.atlas = "images/inventoryimages/mushroom_hat.xml"

local weather_machine = Recipe("weather_machine", { Ingredient("gears", 6), Ingredient("crystal_fragment_black", 6, "images/inventoryimages/crystal_fragment_black.xml") , Ingredient("bluegem", 4)}, RECIPETABS.SCIENCE, TECH.FABLE_1, "weather_machine_placer")
weather_machine.atlas = "images/inventoryimages/weather_machine.xml"

local refiner = Recipe("refiner", { Ingredient("crystal_fragment_spire", 6, "images/inventoryimages/crystal_fragment_spire.xml"), Ingredient("cloud_coral_fragment", 6, "images/inventoryimages/cloud_coral_fragment.xml"), Ingredient("thunderboards", 3, "images/inventoryimages/thunderboards.xml") }, RECIPETABS.SCIENCE, TECH.FABLE_1, "refiner_placer")
refiner.atlas = "images/inventoryimages/refiner.xml"

local research_lectern = Recipe("research_lectern", { Ingredient("goldnugget", 4), Ingredient("crystal_fragment_relic", 2, "images/inventoryimages/crystal_fragment_relic.xml"), Ingredient("thunder_log", 6, "images/inventoryimages/thunder_log.xml") }, RECIPETABS.SCIENCE, TECH.SCIENCE_TWO, "research_lectern_placer")
research_lectern.atlas = "images/inventoryimages/research_lectern.xml"

local cotton_candy = Recipe("cotton_candy", { Ingredient("cloud_cotton", 6, "images/inventoryimages/cloud_cotton.xml"), Ingredient("candy_fruit", 6, "images/inventoryimages/candy_fruit.xml") }, RECIPETABS.FARM, TECH.FABLE_1)
cotton_candy.atlas = "images/inventoryimages/cotton_candy.xml"

local grabber = Recipe("grabber", { Ingredient("magnet", 2, "images/inventoryimages/cloud_cotton.xml"), Ingredient("twigs", 8), Ingredient("rubber", 4, "images/inventoryimages/cloud_cotton.xml") }, RECIPETABS.TOOLS, TECH.FABLE_1)
grabber.atlas = "images/inventoryimages/grabber.xml"

local wind_axe = Recipe("wind_axe", { Ingredient("crystal_fragment_water", 2, "images/inventoryimages/crystal_fragment_water.xml"), Ingredient("twigs", 8), Ingredient("rope", 2) }, RECIPETABS.WAR, TECH.FABLE_1)
wind_axe.atlas = "images/inventoryimages/wind_axe.xml"

local magnet = Recipe("magnet", { Ingredient("gears", 2), Ingredient("crystal_fragment_spire", 3, "images/inventoryimages/crystal_fragment_spire.xml"), Ingredient("rope", 4) }, RECIPETABS.SCIENCE, TECH.FABLE_1)
magnet.atlas = "images/inventoryimages/magnet.xml"

local crystal_lamp = Recipe("crystal_lamp", { Ingredient("beanlet_shell", 1, "images/inventoryimages/beanlet_shell.xml"), Ingredient("crystal_fragment_light", 4, "images/inventoryimages/crystal_fragment_light.xml"), Ingredient("rope", 3) }, RECIPETABS.LIGHT, TECH.FABLE_1, "crystal_lamp_placer")
crystal_lamp.atlas = "images/inventoryimages/crystal_lamp.xml"

local beanstalk_wall_item = Recipe("beanstalk_wall_item", { Ingredient("beanstalk_chunk", 4, "images/inventoryimages/beanstalk_chunk.xml"), Ingredient("twigs", 1) }, RECIPETABS.TOWN, TECH.FABLE_1,nil,nil,nil,6)
beanstalk_wall_item.atlas = "images/inventoryimages/beanstalk_wall_item.xml"

local crystal_wall_item = Recipe("crystal_wall_item", { Ingredient("crystal_fragment_light", 4, "images/inventoryimages/crystal_fragment_light.xml"), Ingredient("crystal_fragment_water", 4, "images/inventoryimages/crystal_fragment_water.xml"), Ingredient("crystal_fragment_spire", 4, "images/inventoryimages/crystal_fragment_spire.xml") }, RECIPETABS.TOWN, TECH.FABLE_1,nil,nil,nil,6)
crystal_wall_item.atlas = "images/inventoryimages/crystal_wall_item.xml"

local refined_black_crystal = Recipe("refined_black_crystal", { Ingredient("crystal_fragment_black", 6, "images/inventoryimages/crystal_fragment_black.xml") }, RECIPETABS.REFINE, TECH.FABLE_1)
refined_black_crystal.atlas = "images/inventoryimages/refined_black_crystal.xml"

local refined_white_crystal = Recipe("refined_white_crystal", { Ingredient("crystal_fragment_white", 6, "images/inventoryimages/crystal_fragment_white.xml") }, RECIPETABS.REFINE, TECH.FABLE_1)
refined_white_crystal.atlas = "images/inventoryimages/refined_white_crystal.xml"

local thunderboards = Recipe("thunderboards", { Ingredient("thunder_log", 6, "images/inventoryimages/thunder_log.xml") }, RECIPETABS.REFINE, TECH.FABLE_1)
thunderboards.atlas = "images/inventoryimages/thunderboards.xml"

local blackstaff = Recipe("blackstaff", { Ingredient("spear", 1), Ingredient("refined_black_crystal", 1, "images/inventoryimages/refined_black_crystal.xml"), Ingredient("nightmarefuel", 6) }, RECIPETABS.MAGIC, TECH.FABLE_1)
blackstaff.atlas = "images/inventoryimages/blackstaff.xml"

local whitestaff = Recipe("whitestaff", { Ingredient("spear", 1), Ingredient("refined_white_crystal", 1, "images/inventoryimages/refined_white_crystal.xml"), Ingredient("nightmarefuel", 6) }, RECIPETABS.MAGIC, TECH.FABLE_1)
whitestaff.atlas = "images/inventoryimages/whitestaff.xml"
