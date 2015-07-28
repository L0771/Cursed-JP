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
			local grid = player.get_inventory(defines.inventory.player_armor)[1].grid
			for k,v in pairs(grid.equipment) do
				if v.name == "cursed-jp" then
					if global.cursedJP[player.name] == false then
						global.cursedJP[player.name] = true
						changeBody(player)
					end
					return
				end
			end
			if global.cursedJP[player.name] == true then
				global.cursedJP[player.name] = false
				changeBody(player)
			end
		end
	end
end)


game.on_event(defines.events.on_player_created, function(event)
	local player = game.get_player(event.player_index)
	if player.name == "" then
		error("Use a nick in Options > Others")
	end
	if global.cursedJP[player.name] == nil then
		global.cursedJP[player.name] = false
	end
end)

function changeBody(player)
	local items = {}
	if player.character.has_items_inside() or player.character.cursor_stack.valid_for_read then
		local n = 1
		local player_quickbar = player.character.get_inventory(defines.inventory.player_quickbar)
		for i = 1, #player_quickbar do
			if player_quickbar[i].valid_for_read then
				items[n] = {name=player_quickbar[i].name,count=player_quickbar[i].count}
				n = n + 1
			end
		end
		local player_main = player.character.get_inventory(defines.inventory.player_main) 
		for i = 1, #player_main do
			if player_main[i].valid_for_read then
				items[n] = {name=player_main[i].name,count=player_main[i].count}
				n = n + 1
			end
		end
		local player_guns = player.character.get_inventory(defines.inventory.player_guns) 
		for i = 1, #player_guns do
			if player_guns[i].valid_for_read then
				items[n] = {name=player_guns[i].name,count=player_guns[i].count}
				n = n + 1
			end
		end
		local player_tools = player.character.get_inventory(defines.inventory.player_tools) 
		for i = 1, #player_tools do
			if player_tools[i].valid_for_read then
				items[n] = {name=player_tools[i].name,count=player_tools[i].count}
				n = n + 1
			end
		end
		local player_ammo = player.character.get_inventory(defines.inventory.player_ammo) 
		for i = 1, #player_ammo do
			if player_ammo[i].valid_for_read then
				items[n] = {name=player_ammo[i].name,count=player_ammo[i].count}
				n = n + 1
			end
		end
		local player_armor = player.character.get_inventory(defines.inventory.player_armor) 
		for i = 1, #player_armor do
			if player_armor[i].valid_for_read then
				items[n] = {name=player_armor[i].name,count=player_armor[i].count}
				n = n + 1
			end
		end
		local cursor_stack = player.character.cursor_stack
		if cursor_stack.valid_for_read then
			items[n] = {name=cursor_stack.name,count=cursor_stack.count}
			n = n + 1
		end
	end
	local inside = {}
	if player.character and (player.get_inventory(defines.inventory.player_armor)[1] ~= nil) then
		local adentro = player.get_inventory(defines.inventory.player_armor)[1].grid.equipment
		for i = 1, #adentro do
			inside[#inside+1] = {name = adentro[i].name, position = adentro[i].position}
		end
	end
	local old = player.character
	local new
	if global.cursedJP[player.name] == true then
		new = player.surface.create_entity{name=player.character.name .. "_jp", position=player.position, force=player.force}
	else
		new = player.surface.create_entity{name=string.sub(player.character.name,1,-4), position=player.position, force=player.force}
	end
	for i = 1, #items do
		new.insert(items[i])
	end
	player.set_controller({type = defines.controllers.character, character = new})
	if player.get_inventory(defines.inventory.player_armor)[1].has_grid then
		local grid = player.get_inventory(defines.inventory.player_armor)[1].grid
		for i = 1, #inside do
			grid.put{name = inside[i].name, position = inside[i].position}
		end
	end
	old.destroy()
end
