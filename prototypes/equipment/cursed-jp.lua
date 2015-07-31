
local obj = util.table.deepcopy(data.raw["movement-bonus-equipment"]["basic-exoskeleton-equipment"])
obj.name = "cursed-jp"
obj.movement_bonus = 0
obj.energy_consumption = (tonumber(string.sub(obj.energy_consumption,1,-3)) * 5) .. string.sub(obj.energy_consumption,-2)
obj.sprite =
    {
      filename = "__Cursed-JP__/graphics/equipment/cursed-jp.png",
      width = 128,
      height = 128,
      priority = "medium"
    }
obj.shape.width = 4
obj.shape.height = 4
obj.energy_source.usage_priority = "primary-input"
data.raw[obj.type][obj.name] = obj
