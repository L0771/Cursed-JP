require("defines")

game.on_init(function()
	for k,force in pairs(game.forces) do
		if force.technologies["basic-exoskeleton-equipment"].researched == true then
			force.technologies["cursed-jp"].enabled = true
		end
	end
	local jp = global.cursedJP
	if global.cursedJP == nil then
		global.cursedJP = {}
	end
end)


game.on_event(defines.events.on_tick, function(event)
	if event.tick % 60 == 0 then
		for _,player in ipairs(game.players) do
			if not (player.character.cursor_stack.valid_for_read and player.character.cursor_stack.type == "armor") then
				local armor = player.get_inventory(defines.inventory.player_armor)[1]
				if armor.valid_for_read and armor.has_grid then
					for k,v in pairs(armor.grid.equipment) do
						if v.name == "cursed-jp" and v.energy == v.max_energy then
							if string.sub(player.character.name,-3) ~= "_jp" then
								if global.cursedJP[player.index] == false then
									global.cursedJP[player.index] = true
									changeBody(player)
								end
							end
							return
						end
					end
				end
				if global.cursedJP[player.index] == true then
					global.cursedJP[player.index] = false
					if string.sub(player.character.name,-3) == "_jp" then
						changeBody(player)
					end
				end
			end
		end
	end
end)


game.on_event(defines.events.on_player_created, function(event)
	local player = game.get_player(event.player_index)
	if global.cursedJP[player.index] == nil then
		global.cursedJP[player.index] = false
	end
end)

function changeBody(player)
	local old = player.character
	local new
	if global.cursedJP[player.index] == true then
		new = player.surface.create_entity{name=player.character.name .. "_jp", position=player.position, force=player.force}
	else
		new = player.surface.create_entity{name=string.sub(player.character.name,1,-4), position=player.position, force=player.force}
	end
	moveInside(old.get_inventory(defines.inventory.player_guns),new,defines.inventory.player_guns)
	moveInside(old.get_inventory(defines.inventory.player_ammo),new,defines.inventory.player_ammo)
	moveInside(old.get_inventory(defines.inventory.player_tools),new,defines.inventory.player_tools)
	moveInside(old.get_inventory(defines.inventory.player_armor),new,defines.inventory.player_armor)
	moveInside(old.get_inventory(defines.inventory.player_quickbar),new,defines.inventory.player_quickbar)
	moveInside(old.get_inventory(defines.inventory.player_main),new,defines.inventory.player_main)
	local cursor = old.cursor_stack
	player.set_controller({type = defines.controllers.character, character = new})
	player.character.cursor_stack.set_stack(cursor)
	old.destroy()
end

function moveInside(inventory,newBody,loc)
	for i = 1, #inventory do
		if inventory[i].valid_for_read then
			newBody.insert(inventory[i])
			if game.item_prototypes[inventory[i].name].type == "armor" and inventory[i].has_grid and #inventory[i].grid.equipment ~= 0 then
				local newInv = newBody.get_inventory(loc)
				for j = 1, #newInv do
					if newInv[j].valid_for_read and newInv[j].name == inventory[i].name and newInv[j].has_grid and #newInv[j].grid.equipment == 0 then
						local inside = inventory[i].grid.equipment
						for k = 1, #inside do
							newInv[j].grid.put(inside[k])
						end
						return
					end
				end
			end
		end
	end
end