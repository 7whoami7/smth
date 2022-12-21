ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(200)
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
    end
end)

Citizen.CreateThread(function()

    for k, shop in pairs(Config.Shops) do
		if shop.blip ~= false then
		
			local name = shop.name or 'Shop'
			
			local blip = AddBlipForCoord(shop.x, shop.y, shop.z)
			SetBlipSprite (blip, shop.blip)
			SetBlipScale  (blip, 0.9)
			SetBlipDisplay(blip, 4)
			SetBlipColour (blip, shop.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING') 
			AddTextComponentString(name)
			EndTextCommandSetBlipName(blip)
		end
    end

end)

_menuPool  = NativeUI.CreatePool()
local isNearShop = false
local isAtShop = false
local isPedLoaded = false
local npc = nil

local mainMenu

local currentShop = nil

Citizen.CreateThread(function()
    while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        isAtShop = false
        isNearShop = false

        for k, v in pairs(Config.Shops) do
            --print(v.x)
            local distance = Vdist(playerCoords, v.x, v.y, v.z)
            --print(distance)
            if distance < 2.5 then
                isNearShop = true
                isAtShop = true
                currentShop = v

            elseif distance < 25.0 then
                isNearShop = true
                currentShop = v

                if not isPedLoaded then
                    
					RequestModel(GetHashKey(v.pedmodel))
					while not HasModelLoaded(GetHashKey(v.pedmodel)) do
						Wait(1)
					end
					npc = CreatePed(4, GetHashKey(v.pedmodel), v.x, v.y, v.z - 1.0, v.rot, false, true)
					FreezeEntityPosition(npc, true)	
					SetEntityHeading(npc, v.rot)
					SetEntityInvincible(npc, true)
					SetBlockingOfNonTemporaryEvents(npc, true)                    
					isPedLoaded = true
					
				end
            end
        end

        if (isPedLoaded and not isNearShop) then
            DeleteEntity(npc)
			SetModelAsNoLongerNeeded(GetHashKey(ped))
			isPedLoaded = false
		end
        Citizen.Wait(350)
    end
end)


Citizen.CreateThread(function()
    while true do

        if _menuPool:IsAnyMenuOpen() then 
            _menuPool:ProcessMenus()
        end

        if isAtShop then
            showInfobar(Translation[Config.Locale]['infobar_interact'])
            if IsControlJustReleased(0, 38) then
                generateShopMenu()
            end
        end
        Citizen.Wait(1)
    end
end)

-- kaufen / verkaufen
-- stock?
-- 
function generateShopMenu()

    if mainMenu ~= nil and mainMenu:Visible() then
        mainMenu:Visible(false)
    end

    mainMenu   = NativeUI.CreateMenu('', nil)
    local background = Sprite.New(currentShop.banner, currentShop.banner, 0, 0, 431, 38)
    mainMenu:SetBannerSprite(background, true)
    _menuPool:Add(mainMenu)

    print(currentShop.type)

    local currentIndex = 1
    mainMenu.OnIndexChange = function(menu, index)
        print(index)
        currentIndex = index
    end

    for k, v in pairs(Config.ShopItems[currentShop.type]) do
        local itemSubmenu = _menuPool:AddSubMenu(mainMenu, v.label)
        itemSubmenu:SetBannerSprite(background, true)
        mainMenu.Items[k]:RightLabel('~g~' .. v.price .. '$')

        local sellItem = NativeUI.CreateItem(Translation[Config.Locale]['buy'], '~b~')
        itemSubmenu:AddItem(sellItem)
        sellItem:RightLabel('~g~' .. v.price .. '$')

        sellItem.Activated = function(sender, index)
            local onScreenDisplayResult_shopmenu_amount = CreateDialog(Translation[Config.Locale]['how_much'])
			if (onScreenDisplayResult_shopmenu_amount ~= nil) then
				if tonumber(onScreenDisplayResult_shopmenu_amount) then
                    TriggerServerEvent('myShops:buyItem', currentIndex, tonumber(onScreenDisplayResult_shopmenu_amount), Config.ShopItems[currentShop.type])
                end

            end
        end

        if Config.EnableBuyOption then
            local buyItem = NativeUI.CreateItem(Translation[Config.Locale]['sell'], '~b~')
            itemSubmenu:AddItem(buyItem)
            buyItem:RightLabel('~r~' .. math.floor(v.price / Config.PriceBuyDivide) .. '$')

            buyItem.Activated = function(sender, index)
                local onScreenDisplayResult_shopmenu_amount = CreateDialog(Translation[Config.Locale]['how_much_sell'])
                if (onScreenDisplayResult_shopmenu_amount ~= nil) then
                    if tonumber(onScreenDisplayResult_shopmenu_amount) then
                        TriggerServerEvent('myShops:sellItem', currentIndex, tonumber(onScreenDisplayResult_shopmenu_amount), Config.ShopItems[currentShop.type])
                    end
    
                end
            end
        end
        


    end

    mainMenu:Visible(true)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled (false)
    _menuPool:MouseEdgeEnabled (false)
    _menuPool:ControlDisablingEnabled(false)
end

function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
	AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
	DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local displayResult = GetOnscreenKeyboardResult()
		return displayResult
	end
end

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

function showPictureNotification(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end

RegisterNetEvent('myShops:picturemsg')
AddEventHandler('myShops:picturemsg', function(icon, msg, title, subtitle)
	showPictureNotification(icon, msg, title, subtitle)
end)

RegisterNetEvent('myShops:receiveNotification')
AddEventHandler('myShops:receiveNotification', function(message)
	ShowNotification(message)
end)