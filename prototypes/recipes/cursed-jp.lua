
local obj = util.table.deepcopy(data.raw["recipe"]["basic-exoskeleton-equipment"])
obj.name = "cursed-jp"
for _,ing in ipairs(obj.ingredients) do
	ing[2] = ing[2] * 2
end
obj.results = {}
obj.results[1] = {}
obj.results[1].type = "item"
obj.results[1].name = "cursed-jp"
obj.results[1].amount = 1
data.raw[obj.type][obj.name] = obj
