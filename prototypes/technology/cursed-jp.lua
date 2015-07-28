
local obj = util.table.deepcopy(data.raw["technology"]["basic-exoskeleton-equipment"])
obj.name = "cursed-jp"
obj.effects = {}
obj.effects[3] = { type = "unlock-recipe", recipe = "cursed-jp" }
obj.unit.time = obj.unit.time * 2
obj.unit.count = obj.unit.count * 2
obj.prerequisites = {"basic-exoskeleton-equipment"}
data.raw[obj.type][obj.name] = obj
