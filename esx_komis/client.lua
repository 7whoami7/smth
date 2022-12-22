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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Komis                   = false

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
	SetKomis(ESX.Player.GetSecondJob('komis'))
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	SetKomis(ESX.Player.GetSecondJob('komis', xPlayer))
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	SetKomis(ESX.Player.GetSecondJob('komis'))
end)

function SetKomis(status)
	Komis = (type(status) == 'table' and status or false)
end

AddEventHandler('esx_komis:hasEnteredMarker', function(zone)
	if zone == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = 'Naciśnij ~INPUT_CONTEXT~ aby otworzyć panel zarządzania'
	end
end)

AddEventHandler('esx_komis:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		if PlayerData.job and (PlayerData.job.name == 'komis' or Komis) then
			Citizen.Wait(0)
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)

			if #(coords - vec3(Config.BossActions.x, Config.BossActions.y, Config.BossActions.z)) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.BossActions.x, Config.BossActions.y, Config.BossActions.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if PlayerData.job and (PlayerData.job.name == 'komis' or Komis) then
			Citizen.Wait(100)
			local isInMarker  = false
			local currentZone = nil

			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			if #(coords - vec3(Config.BossActions.x, Config.BossActions.y, Config.BossActions.z)) < Config.MarkerSize.x then
				isInMarker  = true
				currentZone = 'BossActions'
			end

			if isInMarker and not HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_komis:hasEnteredMarker', currentZone)
			end
			
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_komis:hasExitedMarker', LastZone)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if CurrentAction then
			Citizen.Wait(0)
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)

			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, Keys['E']) and PlayerData.job and (PlayerData.job.name == 'komis' or Komis) then
				if CurrentAction == 'menu_boss_actions' then
					local opts = {}
					if PlayerData.job.grade_name ~= 'boss' and (not Komis or Komis.grade_name ~= 'boss') then
						opts.withdraw = false
						opts.employees = false
					end

					TriggerEvent('esx_society:openBossMenu', 'komis', function(data, menu)
						menu.close()
					end, opts)
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(200)
		end
	end
end)