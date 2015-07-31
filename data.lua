
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


--[[
methods:
can_reach_entity
clear_gui_arrow
clear_items_inside
clear_selected_entity
enable_flashlight
has_items_inside
set_gui_arrow
update_selected_entity
get_request_slot
get_transport_line
is_closed
is_closing
is_crafting
is_open

values:
crafting_queue_size[R]
cursor_stack[R]
driving[RW]
mininig_state[RW]
riding_state[RW]
surface[R]
walking_state[RW]
belt_to_ground_type[R]
bonus_progress[R]
color[RW]
crafting_progress[R]
ghost_localised_name[R]
ghost_name[R]
ghost_prototype[R]
ghost_type[R]
time_to_live[RW]
valid[R]
]]