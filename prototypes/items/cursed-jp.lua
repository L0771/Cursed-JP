
local obj = util.table.deepcopy(data.raw["item"]["basic-exoskeleton-equipment"])
obj.name = "cursed-jp"
obj.placed_as_equipment_result = "cursed-jp"
--obj.icon = "__Cursed-UG__/graphics/icons/cargo-wagon-ug/cursed-cargo-wagon-ug.png"
data.raw[obj.type][obj.name] = obj
