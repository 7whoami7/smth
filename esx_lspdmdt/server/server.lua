local CharCount, VehCount, LiczbaMandatowPrzezMiesiac, LiczbaMandatowPrzezTydzien, PhoneNumber, KartotekaSearch, Police, OstatnieMandatySelect, VehiclesByPlate, VehiclesByCharid, PropertiesByCharid, NotepadSelect, NotepadInsert, NotepadUpdate, OgloszeniaSelect, OgloszeniaInsert, OgloszeniaDelete, RaportySelect, RaportyInsert, RaportDelete, JudgmentsSelect, JudgmentsInsert, JudgmentsDelete, PoszukiwaniaSelect, PoszukiwaniaInsert, PoszukiwaniaDelete, KartotekaNotatkiSelect, KartotekaNotatkiInsert, KartotekaNotatkiDelete, IdentifierFromPhoneNumber = -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
local array = nil
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
    Properties = {}
    CharCount = MySQL.Sync.store("SELECT COUNT(*) FROM `users`");
    VehCount = MySQL.Sync.store("SELECT COUNT(*) FROM `owned_vehicles`");
    LiczbaMandatowPrzezMiesiac = MySQL.Sync.store("SELECT COUNT(*) FROM `lspdmdt_judgments`WHERE date between date_sub(now(),INTERVAL 1 MONTH) and now();")
    LiczbaMandatowPrzezTydzien = MySQL.Sync.store("SELECT COUNT(*) FROM `lspdmdt_judgments` WHERE date between date_sub(now(),INTERVAL 1 WEEK) and now();")
    PhoneNumber = MySQL.Sync.store("SELECT `phone_number` FROM `users` WHERE `identifier` = ?")
    IdentifierFromPhoneNumber = MySQL.Sync.store("SELECT `identifier` FROM `users` WHERE `phone_number` = ?")
    MySQL.Async.store("SELECT `identifier`, `firstname`, `lastname`, `dateofbirth`, `phone_number` FROM `users` WHERE `firstname` = ? AND `lastname` = ?", function(storeId)
        KartotekaSearch = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_judgments` WHERE date between date_sub(now(),INTERVAL 1 WEEK) and now() ORDER BY id DESC;", function(storeId)
		OstatnieMandatySelect = storeId
	end)
    MySQL.Async.store('SELECT users.firstname, users.lastname, users.phone_number, owned_vehicles.vehicle, owned_vehicles.plate FROM owned_vehicles INNER JOIN users ON owned_vehicles.owner = users.identifier WHERE owned_vehicles.plate LIKE ?;', function(storeId)
		VehiclesByPlate = storeId
	end)
    MySQL.Async.store('SELECT `vehicle`, `plate` FROM `owned_vehicles` WHERE `identifier` = ?', function(storeId)
		VehiclesByCharid = storeId
	end)
    MySQL.Async.store('SELECT `name` FROM `owned_properties` WHERE `identifier` = ?', function(storeId)
		PropertiesByCharid = storeId
	end)
    MySQL.Async.store("SELECT `notatka` FROM `lspdmdt_notatki` WHERE `identifier` = ?", function(storeId)
		NotepadSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_notatki`(`identifier`, `notatka`) VALUES (?,?)', function(storeId)
        NotepadInsert = storeId
    end)
    MySQL.Async.store('UPDATE `lspdmdt_notatki` SET `notatka` = ? WHERE `identifier` = ?', function(storeId)
        NotepadUpdate = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_ogloszenia`", function(storeId)
		OgloszeniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_ogloszenia`(`fp`, `ogloszenie`) VALUES (?,?)', function(storeId)
        OgloszeniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_ogloszenia` WHERE `fp` = ? AND `ogloszenie` = ?', function(stroeId)
        OgloszeniaDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_raporty`", function(storeId)
		RaportySelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_raporty`(`fp`, `raport`) VALUES (?,?)', function(storeId)
        RaportyInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_raporty` WHERE `fp` = ? AND `raport` = ?', function(stroeId)
        RaportDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_judgments` WHERE `identifier` = ?", function(storeId)
		JudgmentsSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_judgments`(`identifier`, `charname`, `fp`, `reason`, `fee`, `length`) VALUES (?,?,?,?,?,?)', function(storeId)
        JudgmentsInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_judgments` WHERE `id` = ? AND `identifier` = ?', function(storeId)
        JudgmentsDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_poszukiwani` WHERE `identifier` = ?", function(storeId)
		PoszukiwaniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_poszukiwani`(`identifier`, `fp`, `reason`) VALUES (?,?,?)', function(storeId)
        PoszukiwaniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_poszukiwani` WHERE `identifier` = ? AND `reason` = ?', function(storeId)
        PoszukiwaniaDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_kartoteka_notatki` WHERE `identifier` = ?", function(storeId)
		KartotekaNotatkiSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_kartoteka_notatki`(`identifier`, `notatka`, `fp`) VALUES (?,?,?)', function(storeId)
        KartotekaNotatkiInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_kartoteka_notatki` WHERE `identifier` = ? AND `notatka` = ?', function(storeId)
        KartotekaNotatkiDelete = storeId
    end)

    MySQL.Async.fetchAll('SELECT name, label, entering FROM properties', {}, function(result)		
		if result[1] ~= nil then
			for k,v in ipairs(result) do
				Properties[v.name] = {
					label = v.label,
					coords = v.entering
				}		
			end	
		end
	end)
    Polices = MySQL.Sync.fetchAll("SELECT `identifier`, `firstname`, `lastname`, `phone_number`, `odznaka` FROM `users` WHERE `job` = ?", {"police"})
    
	for k,v in pairs(Polices) do
        v.duty_status = 1
        v.color = "red"
    end
end)

GetIdCard = function(charid)
	if charid == nil then
		return 'Brak danych'
	end
	
	local xPlayer = ESX.GetPlayerFromIdentifier(charid)
	if xPlayer ~= nil then
		return xPlayer.character.firstname..' '..xPlayer.character.lastname
	else
		local data = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @charid', {
			['@charid']	= charid
		})	
		
		if data[1] ~= nil then
			return data[1].firstname..' '..data[1].lastname
		else
			return 'Brak danych'	
		end
	end
end

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then

        if xPlayer.job.name == 'police' then
            array = Polices
        end
		
        for k,v in pairs(array) do
            if xPlayer.identifier == v.identifier then
                v.duty_status = 1
                v.color = "red"
            end
        end
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:GetVehicleByPlate', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll(VehiclesByPlate, {plate..'%'}, function(result)
            local vehdata = {}
            
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                local numer_telefonu = v.phone_number
                if(numer_telefonu == "") then
                    numer_telefonu = "Brak"
                end
                local veharray = {
                    ownername = v.firstname.." "..v.lastname,
                    plate = v.plate,
                    model = vehicle.name,
                    phone_number = numer_telefonu
                }
                table.insert(vehdata, veharray)
            end
            cb(vehdata)
        end)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)


ESX.RegisterServerCallback('esx_lspdmdt:GetWeaponBySerial', function(source, cb, serial)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local Items = ESX.GetItems()
        number = tonumber(serial)
        
        if number ~= nil then
            number = tostring(number)
            
            local Weapon = Items[number]
            if Weapon then
                local numer_telefonu = MySQL.Sync.fetchScalar(PhoneNumber, {Weapon.data.identifier})
                if(numer_telefonu == "") then
                    numer_telefonu = "Brak"
                end
                local weaponarray = {
                    ownername = ESX.GetIdCard(Weapon.data.identifier),
                    serial = serial,
                    model = Weapon.label,
                    phone_number = numer_telefonu
                }	
                cb(weaponarray)
            end
        end
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:SearchNumber', function(source, cb, numer)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then		
        local identifier = MySQL.Sync.fetchScalar(IdentifierFromPhoneNumber, {numer})
        print(identifier)
        local numerarray = {
            ownername = GetIdCard(identifier),
            phone_number = numer
        }
        cb(numerarray)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:SearchPersonKartoteka', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll(KartotekaSearch, {data.firstname, data.lastname}, function(result)
            cb(result)
        end)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)


RegisterServerEvent('esx_lspdmdt:WystawMandat')
AddEventHandler('esx_lspdmdt:WystawMandat', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local fp = "["..xPlayer.character.odznaka.."] "..xPlayer.character.firstname.." "..xPlayer.character.lastname
        local name = xTarget.character.firstname..' '..xTarget.character.lastname
        local mandat = tonumber(data.fee)
        MySQL.Async.execute(JudgmentsInsert, {xTarget.identifier, xTarget.character.firstname.." "..xTarget.character.lastname, fp, data.text, mandat, 0})
            
        xTarget.removeAccountMoney('bank', mandat)

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..xPlayer.job.name, function(account)
            if account then
                account.addMoney('money', mandat * 0.80)
            end
        end)
        
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message"> <i class="far fa-newspaper" style="color:rgba(0, 153, 204, 1.0)"></i> <span class="chat-text"> &nbsp; {0}: {1} </span> </div>',
            args = {'MANDAT', name..' ^2 dostał mandat o wartosci ^7'..mandat..'$ ^1| ^2Powod: ^7'..data.text..' ^1| ^2Funkcjonariusz: ^7'..fp..'^1'}
        })	
            
        --log
    else
        DropPlayer(_source, "esx_lspdmdt: don't touch this!")
    end
end)


RegisterNetEvent('esx_lspdmdt:WystawWiezienie')
AddEventHandler('esx_lspdmdt:WystawWiezienie', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local fp = "["..xPlayer.character.odznaka.."] "..xPlayer.character.firstname.." "..xPlayer.character.lastname
        local name = xTarget.character.firstname..' '..xTarget.character.lastname
        local mandat = tonumber(data.fee)

        MySQL.Async.execute(JudgmentsInsert, {xTarget.charid, xTarget.character.firstname.." "..xTarget.character.lastname, fp, data.text, mandat, data.length})

        xTarget.removeAccountMoney('bank', mandat)

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..xPlayer.job.name, function(account)
			if account then
				account.addMoney('money', mandat * 0.80)
			end
		end)

        TriggerEvent("esx_jtestailer:sendToJailPanelhype", xTarget.source, data.length * 60, data.text)
		
	    --log
    else
        DropPlayer(_source, "esx_lspdmdt: don't touch this!")
    end
end)


RegisterServerEvent("esx_lspdmdt:SendMdtData")
AddEventHandler("esx_lspdmdt:SendMdtData", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
        if xPlayer.job.name == 'police' then
    
            if xPlayer.job.name == 'police' then
                array = Polices
            end
			
            local MdtData = {
                charCount = MySQL.Sync.fetchScalar(CharCount),
                vehCount = MySQL.Sync.fetchScalar(VehCount),
                mandatyMiesiac = MySQL.Sync.fetchScalar(LiczbaMandatowPrzezMiesiac);
                mandatyTydzien = MySQL.Sync.fetchScalar(LiczbaMandatowPrzezTydzien);
                OstatnieMandaty = MySQL.Sync.fetchAll(OstatnieMandatySelect),
                Player = {
                    firstname = xPlayer.character.firstname,
                    lastname = xPlayer.character.lastname,
                    job = xPlayer.job,
                },
                Police = array,
                Notepad = MySQL.Sync.fetchScalar(NotepadSelect, {xPlayer.identifier}),
                Ogloszenia = MySQL.Sync.fetchAll(OgloszeniaSelect),
                Raporty = MySQL.Sync.fetchAll(RaportySelect),
                Taryfikator = Config.Taryfikator
            }	
            TriggerClientEvent("esx_lspdmdt:SendMdtData", _source, MdtData)
        else
            DropPlayer(_source, "esx_lspdmdt: don't touch this!") 
        end
	end
end)

RegisterServerEvent("esx_lspdmdt:UpdatePoliceStatus")
AddEventHandler("esx_lspdmdt:UpdatePoliceStatus", function(type)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then

		local jestwtablicy = false
        if xPlayer.job.name == 'police' then
            array = Polices
        end
		
		if type == 'insert' then
			for k,v in pairs(array) do
				if xPlayer.identifier == v.identifier then
					v.duty_status = 2
					v.color = "green"
					jestwtablicy = true
					break
				end
			end
			if jestwtablicy == false then
				table.insert(array, {
					identifier = xPlayer.identifier,
					firstname = xPlayer.character.firstname,
					lastname = xPlayer.character.lastname,
					phone_number = xPlayer.character.phone_number,
					odznaka = xPlayer.character.odznaka,
					duty_status = 2,
					color = "green"
				})
			end
		elseif type == 'remove' then
			for k,v in pairs(array) do
				if xPlayer.identifier == v.identifier then
					if xPlayer.job.name == 'offduty' then
						v.duty_status = 1
						v.color = "red"
						break
					else
						table.remove(array, k)
						break
					end
				end
			end
		end
        table.sort(array, function(a, b)
            if a ~= nil and b ~= nil and a.duty_status ~= b.duty_status then
                return tonumber(a.duty_status) > tonumber(b.duty_status)
            end
        end)
	end
end)

RegisterServerEvent("esx_lspdmdt:UpdateNotepad")
AddEventHandler("esx_lspdmdt:UpdateNotepad", function(note)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if note ~= nil then        
            MySQL.Async.fetchAll(NotepadSelect, {
                xPlayer.identifier,
            }, function(notepad)
                if notepad[1] then
                    MySQL.Async.execute(NotepadUpdate, {note, xPlayer.identifier})
                else
                    MySQL.Async.execute(NotepadInsert, {xPlayer.identifier, note})
                end		
            end)
        end
    else
        DropPlayer(_source, "esx_lspdmdt: don't touch this!")
    end
end)


ESX.RegisterServerCallback('esx_lspdmdt:SendAnnounce', function(source, cb, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade_name == 'boss' then
        if(text ~= nil and text ~= "") then
            local announcedata = {
                owner = "["..xPlayer.character.odznaka.."] "..xPlayer.character.firstname.." "..xPlayer.character.lastname,
                text = text,
                date = os.time(os.date("!*t"))
            }
            MySQL.Async.execute(OgloszeniaInsert, {announcedata.owner, announcedata.text})
            cb(announcedata)
        end
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent("esx_lspdmdt:RemoveAnnounce")
AddEventHandler("esx_lspdmdt:RemoveAnnounce", function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.ogloszenie ~= nil) then
            MySQL.Async.execute(OgloszeniaDelete, {data.fp, data.ogloszenie})
        end
    else
        DropPlayer(_source, "esx_lspdmdt: don't touch this!") 
    end

end)

ESX.RegisterServerCallback('esx_lspdmdt:SendRaport', function(source, cb, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if(text ~= nil and text ~= "") then
            local raportdata = {
                owner = "["..xPlayer.character.odznaka.."] "..xPlayer.character.firstname.." "..xPlayer.character.lastname,
                text = text,
                date = os.time(os.date("!*t"))
            }
            MySQL.Async.execute(RaportyInsert, {raportdata.owner, raportdata.text})
            cb(raportdata)
        end
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveRaport')
AddEventHandler('esx_lspdmdt:RemoveRaport', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade_name == 'boss' then
        if(data.fp ~= nil and data.raport ~= nil) then
            MySQL.Async.execute(RaportDelete, {data.fp, data.raport})
        end

    else 
        DropPlayer(_source, "esx_lspdmdt: don't touch this!") -- Trigger do esx_lspdmdt: don't touch this!a
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:PersonMoreInfo', function(source, cb, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local charid = data.identifier
        local vehdata = {}
        MySQL.Async.fetchAll(VehiclesByCharid, {charid}, function(result)
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                table.insert(vehdata, {
                    model = vehicle.model,
                    plate = v.plate
                })
            end
        end)
        TriggerEvent('esx_license:getLicenses', {charid = charid}, function(tempdata)
            if tempdata then
                licenses = tempdata
            end
        end)
        local houses = MySQL.Sync.fetchAll(PropertiesByCharid, {
            charid
        })
        
        local temphouse = {}
        
        for k,v in ipairs(houses) do
            local house = Properties[v.name]
            
            if house then
                table.insert(temphouse, {
                    label = house.label,
                    coords = house.coords
                })
            end
        end
        local moreinfodata = {
            mandaty = MySQL.Sync.fetchAll(JudgmentsSelect, {charid}),
            poszukiwania = MySQL.Sync.fetchAll(PoszukiwaniaSelect, {charid}),
            pojadzy = vehdata,
            mieszkania = temphouse,
            notatki = MySQL.Sync.fetchAll(KartotekaNotatkiSelect, {charid}),
            licenses = licenses
        }
        cb(moreinfodata)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:AddPoszukiwaniaKartoteka', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local charid = data.identifier
        local poszukiwaniadata = {
            reason = data.reasonarea,
            fp = "["..xPlayer.character.odznaka.."] "..xPlayer.character.firstname.." "..xPlayer.character.lastname,
            date = os.time(os.date("!*t"))
        }
        cb(poszukiwaniadata)
        MySQL.Async.execute(PoszukiwaniaInsert, {charid, poszukiwaniadata.fp, poszukiwaniadata.reason})
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:AddNotatkaKartoteka', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local charid = data.identifier
        local notedata = {
            notatka = data.note,
            fp = "["..xPlayer.character.odznaka.."] "..xPlayer.character.firstname.." "..xPlayer.character.lastname,
            date = os.time(os.date("!*t"))
        }
        cb(notedata)
        MySQL.Async.execute(KartotekaNotatkiInsert, {charid, notedata.notatka, notedata.fp})
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end

end)


RegisterServerEvent('esx_lspdmdt:licencjaDodaj')
AddEventHandler('esx_lspdmdt:licencjaDodaj', function(data)
    local _source = source
    local charid = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromCharId(charid)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if xTarget ~= nil then
            TriggerEvent('esx_license:addLicense', xTarget.source, data.type, function()
                --log
                xTarget.showNotification('Otrzymałeś licencje: ' .. changekLicenseName(data.type))
            end)
        else
            TriggerEvent('esx_license:addLicense', {charid = charid}, data.type, function()
                --log
            end)
        end
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:licencjaUsun')
AddEventHandler('esx_lspdmdt:licencjaUsun', function(data)
    local _source = source
    local charid = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromCharId(charid)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if xTarget ~= nil then
            TriggerEvent('esx_license:removeLicense', xTarget.source, data.type, function()			
                --log
                xTarget.showNotification('Straciłeś licencje: ' .. changekLicenseName(data.type))
            end)
        else
            TriggerEvent('esx_license:removeLicense', {charid = charid}, data.type, function()
                --log
            end)
        end	
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveMandatKartoteka')
AddEventHandler('esx_lspdmdt:RemoveMandatKartoteka', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local id = data.id
        local charid = data.identifier
        MySQL.Async.execute(JudgmentsDelete, {id, charid})
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemovePoszukiwaniaKartoteka')
AddEventHandler('esx_lspdmdt:RemovePoszukiwaniaKartoteka', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local charid = data.identifier
        local reason = data.reason
        MySQL.Async.execute(PoszukiwaniaDelete, {charid, reason})
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveNotatkiKartoteka')
AddEventHandler('esx_lspdmdt:RemoveNotatkiKartoteka', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local charid = data.identifier
        local note = data.note

        MySQL.Async.execute(KartotekaNotatkiDelete, {charid, note})
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end

end)

function changekLicenseName(licencja)
	local name = "";
	if(licencja == "drive_bike" ) then
		name = "prawo jazdy kat. A"
		return name
	elseif (licencja == "drive" ) then
		name = "prawo jazdy kat. B"
		return name
	elseif (licencja == "drive_truck" ) then
		name = "prawo jazdy kat. C"
		return name
	elseif (licencja == "weapon" ) then
		name = "licencję na broń krótką"
		return name
	elseif (licencja == 'test_psycho') then
		name = "Test psychologiczny:"
		return name		
	end
end