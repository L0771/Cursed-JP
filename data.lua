
for _,player in pairs(data.raw["player"]) do
	if string.sub(player.name,-3) ~= "_jp" then
		local obj = util.table.deepcopy(player)
		obj.name = obj.name .. "_jp"
		obj.collision_box = nil
		obj.collision_mask = { }
		obj.running_speed = obj.running_speed * 1.3
		for _,anim in ipairs(obj.animations) do
			anim.running = anim.idle
			--anim.running_with_gun = anim.idle_with_gun
		end
		data.raw[obj.type][obj.name] = obj
	end
end


		--[equipment]--
require("prototypes.equipment.cursed-jp")

		--[Items]--
require("prototypes.items.cursed-jp")

		--[Recipes]--
require("prototypes.recipes.cursed-jp")

		--[Technologies]--
require("prototypes.technology.cursed-jp")
