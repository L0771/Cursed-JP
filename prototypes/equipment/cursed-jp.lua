
local obj = util.table.deepcopy(data.raw["movement-bonus-equipment"]["basic-exoskeleton-equipment"])
obj.name = "cursed-jp"
obj.movement_bonus = 0
--obj.icon = "__Cursed-UG__/graphics/icons/cargo-wagon-ug/cursed-cargo-wagon-ug.png"
data.raw[obj.type][obj.name] = obj
