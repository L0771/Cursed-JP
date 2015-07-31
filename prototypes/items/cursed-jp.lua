
local obj = util.table.deepcopy(data.raw["item"]["basic-exoskeleton-equipment"])
obj.name = "cursed-jp"
obj.placed_as_equipment_result = "cursed-jp"
obj.icon = "__Cursed-JP__/graphics/icons/cursed-jp.png"
data.raw[obj.type][obj.name] = obj
