local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX = nil
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end
end)

MdtOpened = false

local DeleteGradeMandat = 2
local MenageLicenseGrade = 4

local tabletEntity = nil
local tabletModel = "prop_cs_tablet"
local tabletDict = "amb@world_human_seat_wall_tablet@female@base"
local tabletAnim = "base"

function startTabletAnimation()
	Citizen.CreateThread(function()
	  	RequestAnimDict(tabletDict)
		while not HasAnimDictLoaded(tabletDict) do
			Citizen.Wait(0)
		end
		attachObject()
		TaskPlayAnim(GetPlayerPed(-1), tabletDict, tabletAnim, 8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end



function attachObject()
	if tabletEntity == nil then
		Citizen.Wait(380)
		RequestModel(tabletModel)
		while not HasModelLoaded(tabletModel) do
			Citizen.Wait(1)
		end
		tabletEntity = CreateObject(GetHashKey(tabletModel), 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(tabletEntity, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.10, -0.13, 25.0, 170.0, 160.0, true, true, false, true, 1, true)
	end
end



function stopTabletAnimation()
	if tabletEntity ~= nil then
		StopAnimTask(GetPlayerPed(-1), tabletDict, tabletAnim ,8.0, -8.0, -1, 50, 0, false, false, false)
		DeleteEntity(tabletEntity)
		tabletEntity = nil
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	if ESX.PlayerData.job.name == 'police' then
		TriggerServerEvent('esx_lspdmdt:UpdatePoliceStatus', 'insert')
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if ESX.PlayerData.job.name == 'police' then
		TriggerServerEvent('esx_lspdmdt:UpdatePoliceStatus', 'insert')
	else
		TriggerServerEvent('esx_lspdmdt:UpdatePoliceStatus', 'remove')
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
			if IsControlJustPressed(0, Keys["DELETE"]) then
				OpenPoliceMDT()
			end
		else
			Citizen.Wait(500)
		end
	end
end)


function OpenPoliceMDT()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
		if(MdtOpened == false) then
			MdtOpened = true
			startTabletAnimation()
			SetCursorLocation(0.5, 0.5)
			SetNuiFocus(true, true)
			SendNUIMessage({action = 'OpenMDT'})
			TriggerServerEvent('esx_lspdmdt:SendMdtData')
		end
	else
		Citizen.Wait(500)
	end
end

RegisterNetEvent("esx_lspdmdt:SendMdtData")
AddEventHandler("esx_lspdmdt:SendMdtData", function(data)
	if data then
		data['avatar'] = GetAvatar()
		data['job'] = ESX.PlayerData.job.name
		NotepadData = data['Notepad']
		SendNUIMessage({action = 'SendMDTdata', mdtdata = data})
	end
end)

function GetAvatar()
	local playerPed = PlayerPedId()
	
	local headshot, txd = ESX.Game.GetPedMugshot(playerPed)
	local Avatar = false
	
	if not headshot then
		Avatar = false 
	else				
		ESX.Game.Utils.GetMugShotBase64(txd, function(data)	
			UnregisterPedheadshot(headshot)
			print("elele")
			Avatar = data 
		end)
	end
	print(Avatar)
	return Avatar
end

RegisterNUICallback('GetVehicleByPlate', function(data, cb)
	ESX.TriggerServerCallback("esx_lspdmdt:GetVehicleByPlate", function(vehicledata)
		cb(vehicledata)
	end, data.plate)	
end)

RegisterNUICallback('GetWeaponBySerial', function(data, cb)
	ESX.TriggerServerCallback("esx_lspdmdt:GetWeaponBySerial", function(weapondata)
		cb(weapondata)
	end, data.serial)	
end)

RegisterNUICallback('SearchNumber', function(data, cb)
	print("elo", data.numer)
	ESX.TriggerServerCallback("esx_lspdmdt:SearchNumber", function(numerdata)
		cb(numerdata)
		print(json.encode(numerdata))
	end, data.numer)	
end)

RegisterNUICallback('SearchPersonKartoteka', function(data, cb)
	ESX.TriggerServerCallback("esx_lspdmdt:SearchPersonKartoteka", function(persondata)
		cb(persondata)
	end, data)
end)

RegisterNUICallback('AddPoszukiwaniaKartoteka', function(data, cb)
	ESX.TriggerServerCallback('esx_lspdmdt:AddPoszukiwaniaKartoteka', function(poszukiwaniadata)
		cb(poszukiwaniadata)
	end, data)
end)

RegisterNUICallback('AddNotatkaKartoteka', function(data, cb)
	ESX.TriggerServerCallback('esx_lspdmdt:AddNotatkaKartoteka', function(notedata)
		cb(notedata)
	end, data)
end)

RegisterNUICallback('WystawMandat', function(data)
	TriggerServerEvent('esx_lspdmdt:WystawMandat', data)
end)

RegisterNUICallback('WystawWiezienie', function(data)
	TriggerServerEvent('esx_lspdmdt:WystawWiezienie', data)      
end)

RegisterNUICallback('UpdateNotepad', function(data)
	if data.note ~= NotepadData then
		TriggerServerEvent('esx_lspdmdt:UpdateNotepad', data.note)
	end
end)

RegisterNUICallback('SendAnnounce', function(data, cb)
	if(data.text ~= "") then
		ESX.TriggerServerCallback("esx_lspdmdt:SendAnnounce", function(announcedata)
			cb(announcedata)
		end, data.text)
	end
end)

RegisterNUICallback('RemoveAnnounce', function(data)
	TriggerServerEvent('esx_lspdmdt:RemoveAnnounce', data)
end)

RegisterNUICallback('SendRaport', function(data, cb)
	if(data.text ~= "") then
		ESX.TriggerServerCallback("esx_lspdmdt:SendRaport", function(raportdata)
			cb(raportdata)
		end, data.text)
	end
end)

RegisterNUICallback('RemoveRaport', function(data)
	TriggerServerEvent('esx_lspdmdt:RemoveRaport', data)
end)

RegisterNUICallback('NearbyPlayers', function(data, cb)
	local coords = GetEntityCoords(PlayerPedId(), true)
	local players = {}
	for _, player in ipairs(ESX.Game.GetPlayers(true)) do
		local target = GetPlayerPed(player)
		if #(GetEntityCoords(target, true) - coords) <= 10 then
			local pid = GetPlayerServerId(player)
			if pid then
				table.insert(players, {
					type = 'players',
					name = pid
				})
			end
		end
	end
	cb(players)
end)

RegisterNUICallback('PersonMoreInfo', function(data, cb)
	ESX.TriggerServerCallback("esx_lspdmdt:PersonMoreInfo", function(moreinfodata)
		for i,v in ipairs(moreinfodata.pojadzy) do
			TriggerEvent('esx_vehicleshop:getVehicles', function(base)
				local found = false
				for _, vehicle in ipairs(base) do
					if GetHashKey(vehicle.model) == v.model then
						print(vehicle.name)
						v.model = vehicle.name
						found = true
					end
				end
				if not found then
					local label = GetLabelText(v.model)
					if label ~= "NULL" then
						v.model = label
					end
				end
			end)
		end
		
		moreinfodata.canDeleteMandaty = DeleteGradeMandat <= ESX.PlayerData.job.grade
		moreinfodata.canManageLicenses = MenageLicenseGrade <= ESX.PlayerData.job.grade
		
		cb(moreinfodata)
	end, data)
end)

RegisterNUICallback('licencjaDodaj', function(data)
	TriggerServerEvent('esx_lspdmdt:licencjaDodaj', data)
end)

RegisterNUICallback('licencjaUsun', function(data)
	TriggerServerEvent('esx_lspdmdt:licencjaUsun', data)
end)

RegisterNUICallback('RemoveMandatKartoteka', function(data)
	TriggerServerEvent('esx_lspdmdt:RemoveMandatKartoteka', data)
end)

RegisterNUICallback('RemovePoszukiwaniaKartoteka', function(data)
	TriggerServerEvent('esx_lspdmdt:RemovePoszukiwaniaKartoteka', data)
end)

RegisterNUICallback('RemoveNotatkiKartoteka', function(data)
	TriggerServerEvent('esx_lspdmdt:RemoveNotatkiKartoteka', data)
end)

RegisterNUICallback('setGps', function(data)
	if data then
		SetNewWaypoint(data.coords.x, data.coords.y, data.coords.z)
		ESX.ShowNotification('~g~Zaznaczono dom na GPS')
	else
		ESX.ShowNotification('~r~Nie można zaznaczyć na GPS')
	end
end)

RegisterNUICallback('mdtclose', function()
	MdtOpened = false
	SetNuiFocus(false, false)
	stopTabletAnimation()
end)