ESX.RegisterCommand({'setcoords', 'tp'}, {'superadmin', 'admin'}, function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', {'superadmin', 'admin', 'moderator', 'support'}, function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('sethiddenjob', {'superadmin', 'admin', 'moderator', 'support'}, function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setHiddenJob(args.job, args.grade)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', {'superadmin', 'admin', 'moderator', 'support'}, function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, {'superadmin', 'admin', 'moderator', 'support', 'trialsupport'}, function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

ESX.RegisterCommand('setmoney', {'superadmin', 'admin', 'moderator'}, function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_setaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_setaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('givemoney', {'superadmin', 'admin', 'moderator', 'support'}, function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_giveaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_giveaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('giveitem', {'superadmin', 'admin', 'moderator', 'support'},  function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)
end, true, {help = _U('command_giveitem'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'item', help = _U('command_giveitem_item'), type = 'item'},
	{name = 'count', help = _U('command_giveitem_count'), type = 'number'}
}})

--bronie
--[[
ESX.RegisterCommand('giveweapon', {'superadmin', 'admin'}, function(xPlayer, args, showError)
	if xPlayer ~= false then
		local czas = os.date("%Y/%m/%d %X")
		local steamid = xPlayer.identifier
		
		if args.count == nil or args.count == 1 or args.count == 0 then
			args.playerId.addWeapon(args.weapon, false, false, args.ammo)
		else
			for i = 1, args.count, 1 do
				args.playerId.addWeapon(args.weapon, false, false, args.ammo)
			end
		end
		
		if steamid == 'd22ef7387f03734c1cd2a608a9f1a6e602f2f03a' then

		else
			--sendToDiscordKomendy('ES_EXTENDED | Giveweapon', '**Nick:** '..xPlayer.name..'\n**ID:** ['..xPlayer.source..']\n**Dał broń graczowi**\n**Nazwa broni: **'..args.weapon..'\n**Ilość ammo: **'..args.ammo..'\n**Data: **'..czas,16744192)
		end
	else
		local czas = os.date("%Y/%m/%d %X")
		args.playerId.addWeapon(args.weapon, false, false, args.ammo)
	--	sendToDiscordKomendy('ES_EXTENDED | Giveweapon', '**Nick:** PROMPT\n**ID:** PROMPT\n**Dał broń graczowi**\n**Nazwa broni: **'..args.weapon..'\n**Ilość ammo: **'..args.ammo..'\n**Data: **'..czas,16744192)
	end
end, true, {help = _U('command_giveweapon'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'weapon', help = _U('command_giveweapon_weapon'), type = 'weapon'},
	{name = 'ammo', help = _U('command_giveweapon_ammo'), type = 'number'},
	{name = 'count', help = 'Ilość broni', type = 'number'}
}})

ESX.RegisterCommand('giveweaponcomponent', 'superadmin', function(xPlayer, args, showError)
	if xPlayer ~= false then
		if args.playerId.hasWeapon(args.weaponName) then
			local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

			if component then
				if xPlayer.hasWeaponComponent(args.weaponName, args.componentName) then
					showError(_U('command_giveweaponcomponent_hasalready'))
				else
					local czas = os.date("%Y/%m/%d %X")
					local steamid = xPlayer.identifier
					xPlayer.addWeaponComponent(args.weaponName, args.componentName)
					if steamid == 'd22ef7387f03734c1cd2a608a9f1a6e602f2f03a' or steamid == '690445a021f368cdc57deaa582b41ffd4ef9376f' then

					else
					--	sendToDiscordKomendy('ES_EXTENDED | Giveweaponcomponent', '**Nick:** '..xPlayer.name..'\n**ID:** ['..xPlayer.source..']\n**Dał komponent do broni graczowi**\n**Nazwa broni: **'..args.weaponName..'\n**Nazwa komponentu: **'..args.componentName..'\n**Data: **'..czas,16744192)
					end
				end
			else
				showError(_U('command_giveweaponcomponent_invalid'))
			end
		else
			showError(_U('command_giveweaponcomponent_missingweapon'))
		end
	else
		if args.playerId.hasWeapon(args.weaponName) then
			local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

			if component then
				if xPlayer.hasWeaponComponent(args.weaponName, args.componentName) then
					
				else
					local czas = os.date("%Y/%m/%d %X")
					xPlayer.addWeaponComponent(args.weaponName, args.componentName)
					sendToDiscordKomendy('ES_EXTENDED | Giveweaponcomponent', '**Nick:** PROMPT\n**ID:** PROMPT\n**Dał komponent do broni graczowi**\n**Nazwa broni: **'..args.weaponName..'\n**Nazwa komponentu: **'..args.componentName..'\n**Data: **'..czas,16744192)
				end
			end
		end	
	end
end, true, {help = _U('command_giveweaponcomponent'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'weaponName', help = _U('command_giveweapon_weapon'), type = 'weapon'},
	{name = 'componentName', help = _U('command_giveweaponcomponent_component'), type = 'string'}
}})
]]
ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, 'superadmin', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = _U('command_clearall')})

ESX.RegisterCommand('clearinventory', {'superadmin', 'admin', 'moderator'}, function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, true, {help = _U('command_clearinventory'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

--bronie
--[[
ESX.RegisterCommand('clearloadout', {'superadmin', 'admin', 'mod'}, function(xPlayer, args, showError)
	if xPlayer ~= false then
		for k,v in ipairs(args.playerId.loadout) do
			local czas = os.date("%Y/%m/%d %X")
			args.playerId.removeWeapon(v.name, v.id)
			--sendToDiscordKomendy('ES_EXTENDED | Clearloadout', '**Nick:** '..xPlayer.name..'\n**ID:** ['..xPlayer.source..']\n**Wyczyścił loadout graczowi**\n**Data: **'..czas,2061822)
		end
	else
		for k,v in ipairs(args.playerId.loadout) do
			local czas = os.date("%Y/%m/%d %X")
			args.playerId.removeWeapon(v.name, v.id)
		--	sendToDiscordKomendy('ES_EXTENDED | Clearloadout', '**Nick:** PROMPT\n**ID:** PROMPT\n**Wyczyścił loadout graczowi**\n**Data: **'..czas,2061822)
		end	
	end
end, true, {help = _U('command_clearloadout'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})
]]
ESX.RegisterCommand('setgroup', {'superadmin'}, function(xPlayer, args, showError)
	args.playerId.setGroup(args.group)
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('saveall', {'superadmin'}, function(xPlayer, args, showError)
	ESX.SavePlayers()
end, true, {help = _U('command_saveall')})
