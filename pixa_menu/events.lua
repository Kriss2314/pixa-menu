RegisterNetEvent('pixa_menu:OpenPhone')
AddEventHandler('pixa_menu:OpenPhone', function()
ExecuteCommand('+gcphone')
end)






RegisterNetEvent('pixa_menu:OpenPostac')
AddEventHandler('pixa_menu:OpenPostac', function()
    ESX.UI.Menu.CloseAll()
    SetNuiFocus(true, true)
    OpenMenu(Config.Menus['postac_f1'])
end)

RegisterNetEvent('pixa_menu:currentVehicle')
AddEventHandler('pixa_menu:currentVehicle', function()
    ESX.UI.Menu.CloseAll()
    SetNuiFocus(true, true)
    OpenMenu(Config.Menus['menu_aktualnypojazd'],GetVehiclePedIsIn(PlayerPedId()))
end)


RegisterNetEvent('pixa_menu:pickupSnowball')
AddEventHandler('pixa_menu:pickupSnowball', function()
    ESX.UI.Menu.CloseAll()
    if HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_SNOWBALL')) then
        exports['mythic_notify']:SendAlert('black', 'Posiadasz już snieżkę w ekwipunku!', 4000)
        return
    end
    exports['pixa_misc']:PlayAnimation('anim@mp_snowball', 'pickup_snowball')
    exports['pixa_misc']:ProgressBar('snowball', 1500, 'Podnosisz sniezke', true, true, true, function(finished)
        if finished then
            GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 1, false, true) -- get 2 snowballs each time.
            ClearPedTasks(PlayerPedId())
            exports['mythic_notify']:SendAlert('black', 'Podniosłeś śnieżkę!', 4000)
        else
            ClearPedTasks(PlayerPedId())
        end
    
    end)
    
end)




RegisterNetEvent('pixa_menu:searchPlayer')
AddEventHandler('pixa_menu:searchPlayer', function(entity)
    local ped = GetPlayerPed(entity)
    local id = GetPlayerFromPed(entity)
      local server = GetPlayerServerId(id)
        if DecorExistOn(entity, "_HAS_ROPE") or DecorExistOn(entity, "_IS_DEAD") then
            exports['pixa_misc']:ProgressBar('searchplayer', 5000, 'Przeszukujesz gracza', true, true, true, function(finished)
                if finished then
                    local plyPed = PlayerPedId()
                    local coords = GetEntityCoords(plyPed)
                    if Vdist(coords, GetEntityCoords(entity)) < 3 then
                        TriggerEvent('chezz-inventory:openPlayerInventory', GetPlayerServerId(id), GetPlayerName(id))
                    else
                        exports['mythic_notify']:SendAlert('black', 'Ten gracz jest za daleko!', 4000)
                    end
                end
            end)
        end
end)



RegisterNetEvent('pixa_menu:CarRadio')
AddEventHandler('pixa_menu:CarRadio', function()
    ESX.UI.Menu.CloseAll()
    ExecuteCommand( "carradio" )
end)







RegisterNetEvent('pixa_menu:OpenDoorsMenu')
AddEventHandler('pixa_menu:OpenDoorsMenu', function()
    ESX.UI.Menu.CloseAll()
    SetNuiFocus(true, true)
    OpenMenu(Config.Menus['menu_drzwi'],GetVehiclePedIsIn(PlayerPedId()), true)

end)

RegisterNetEvent('pixa_menu:ImpoundVehicle')
AddEventHandler('pixa_menu:ImpoundVehicle', function(entity)
    local elements = {}
	table.insert(elements, {label = 'Parking strzeżony Los Santos', value = 'parking'})
    table.insert(elements, {label = 'Parking policyjny', value = 'police'})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'impound_menu', {
			title    = 'Gdzie chcesz odholować pojazd? <span style="font-size:30%;"> by matthew</span>',
			align    = 'center',
			elements = elements
		}, function(data, menu)
			local action = data.current.value
            menu.close()
            TaskTurnPedToFaceEntity(PlayerPedId(), entity, -1)
            Wait(1000)
            exports['pixa_misc']:ProgressBar('pixa_misc_impound_vehicle', 5000, 'Odholowujesz pojazd', true, true, true, function(finished)
               if finished then
                if action == 'parking' then
                  exports['kuana_garage']:SaveVehiclePos(entity, vector3(-337.38, -931.99, 31.08))  
                  DeleteVehicle(entity)
                  DeleteEntity(entity)
                  exports['mythic_notify']:SendAlert('black', "Pojazd został odstawiony na parking strzeżony w Los Santos.", 8000, true)
                elseif action == 'police' then
                    TriggerEvent('HRP:ImpoundVeh', entity)
                end  
            end
        end)     
		end, function(data, menu)
			menu.close()
		end)


end)




RegisterNetEvent('pixa_menu:OpenDoorsMenu2')
AddEventHandler('pixa_menu:OpenDoorsMenu2', function(entity)
    local door = GetVehicleDoorLockStatus(entity)
    if door == 1 then
    ESX.UI.Menu.CloseAll()
    SetNuiFocus(true, true)
    OpenMenu(Config.Menus['menu_drzwi'],entity, true)
    else
        exports['mythic_notify']:SendAlert('black', 'Pojazd jest zamknięty!', 6000)
    end 

end)


RegisterNetEvent('pixa_menu:HideInTrunk')
AddEventHandler('pixa_menu:HideInTrunk', function(entity)
    local door = GetVehicleDoorLockStatus(entity)
    if IsPedInAnyVehicle(PlayerPedId()) then return end
    if door == 1 then
    exports['mythic_notify']:SendAlert('black', 'Aby wyjść z bagażnika, otwórz [F1] a następnie wybierz odpowiednią opcję!', 8500)
        TriggerEvent('pixa_misc:GetInTrunk')
    else
        exports['mythic_notify']:SendAlert('black', 'Pojazd jest zamknięty!', 6000)
    end 
end)



RegisterNetEvent('pixa_menu:OpenTrunkInventory')
AddEventHandler('pixa_menu:OpenTrunkInventory', function(entity)
    if IsPedInAnyVehicle(PlayerPedId())  or IsPedRagdoll(PlayerPedId()) then return end

    Wait(200)
  exports['inventory']:OpenVehicleTrunk(entity)

end)

RegisterNetEvent('pixa_menu:PushVehicle')
AddEventHandler('pixa_menu:PushVehicle', function(entity)
  exports['grill']:PushVehicle(entity)

end)


RegisterNetEvent('pixa_menu:FlipVehicle')
AddEventHandler('pixa_menu:FlipVehicle', function(entity)
    local sila = exports['pixa_skill']:GetCurrentSkill('Siłacz').Current 
    if sila < 50 then
        exports['mythic_notify']:SendAlert('black', 'Musisz mieć co najmniej 50% statystyki Siłacz aby wykonać tą akcje!', 6000)
        return
    end
    TaskTurnPedToFaceEntity(PlayerPedId(), entity, 1.0)
    ExecuteCommand('e pchanie')
    TriggerEvent("mythic_progressbar:client:progress", {
        name = "pixa_menu_flip_vehicle",
    duration = 25000,
    label = 'Przewracasz pojazd',
    useWhileDead = true,
    canCancel = true,
    disableMovement = true,
    animation = {
        animDict = "gej",
    anim = "gej",
    },
    prop = {
    model = "gej",
    }
    }, function(status)
     if not status then
        ClearPedTasks(PlayerPedId())
        SetVehicleOnGroundProperly(entity)
     else
        ClearPedTasks(PlayerPedId())
    end
end)

end)


RegisterNetEvent('pixa_menu:deletePed')
AddEventHandler('pixa_menu:deletePed', function(entity)
    local playerPed = PlayerPedId()
exports['pixa_misc']:ProgressBar('pixa_menu_deleteped', 5000, 'Usuwanie peda', false, false, true, function(finished)
 
    

    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity) and not IsPedAPlayer(ped)) then 
        DeleteEntity(entity)
    end 

end)
end)



RegisterNetEvent('pixa_menu:giveMoney')
AddEventHandler('pixa_menu:giveMoney', function(entity)
    local ped = GetPlayerPed(entity)
  local id = GetPlayerFromPed(entity)
    local server = GetPlayerServerId(id)
    local menu = {
        type = 'dialog',
        name = 'fine_show_amount',
        title = 'Kwota rachunku',
        action = function(value)
            ESX.UI.Menu.CloseAll()
            if tonumber(value) == nil then
                exports.pNotify:SendNotification({text = "Nieprawidłowa wartość", type = "info", layout = "centerLeft", timeout = 3000})
                return
            end
            TriggerServerEvent('pixa_menu:givemoney', server, value)
        end
    }
    TriggerEvent('disc-base:openMenu', menu)

end)

RegisterNetEvent('pixa_menu:nadajLicencje')
AddEventHandler('pixa_menu:nadajLicencje', function(entity)
    local ped = GetPlayerPed(entity)
  local id = GetPlayerFromPed(entity)
    local server = GetPlayerServerId(id)
	  ESX.TriggerServerCallback('esx_license:checkLicense', function(has)
		if has then
		TriggerServerEvent('esx_policejob:WeaponLicenseRequestS', server)
		else
		exports.pNotify:SendNotification({text = "Gracz nie ma odbytego kursu strzeleckiego!", type = "info", layout = "centerLeft", queue = "lmao", timeout = 4000})
		end
	end, server, 'ammu')
end)


RegisterNetEvent('pixa_menu:showID')
AddEventHandler('pixa_menu:showID', function(entity)
    local ped = GetPlayerPed(entity)
  local id = GetPlayerFromPed(entity)
    local server = GetPlayerServerId(id)
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), server)
    exports['mythic_notify']:SendAlert('black', 'Pokazałeś/aś dowód dla ID: ' .. server, 6000)
end)

RegisterNetEvent('pixa_menu:showIDYourself')
AddEventHandler('pixa_menu:showIDYourself', function()
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
    exports['mythic_notify']:SendAlert('black', 'Pokazałeś/aś dowód dla samego siebie', 6000)
end)

RegisterNetEvent('pixa_menu:showBadge')
AddEventHandler('pixa_menu:showBadge', function(entity)
    local ped = GetPlayerPed(entity)
    local id = GetPlayerFromPed(entity)
      local server = GetPlayerServerId(id)
      --TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), server)
      TriggerServerEvent('icemallow-badge:showBadgeFromMenu', server)
      exports['mythic_notify']:SendAlert('black', 'Pokazałeś/aś odznakę dla ID: ' .. server, 6000)

end)



RegisterNetEvent('pixa_menu:OpenInventory')
AddEventHandler('pixa_menu:OpenInventory', function()
    Wait(150)
    ExecuteCommand('+inventory')
end)



RegisterNetEvent('pixa_menu:OpenAnimationsMenu')
AddEventHandler('pixa_menu:OpenAnimationsMenu', function()
    exports['dpemotes']:OpenMainAnimationsMenu()
end)

RegisterNetEvent('pixa_menu:OpenGarage')
AddEventHandler('pixa_menu:OpenGarage', function()
    ESX.UI.Menu.CloseAll()
    ExecuteCommand( "garaz" )
end)

RegisterNetEvent('pixa_menu:OpenGarage2')
AddEventHandler('pixa_menu:OpenGarage2', function()
    ESX.UI.Menu.CloseAll()
    ExecuteCommand( "garaz2" )
end)

RegisterNetEvent('pixa_menu:OpenStats')
AddEventHandler('pixa_menu:OpenStats', function()
    ESX.UI.Menu.CloseAll()
    ExecuteCommand( "stats" )
end)

RegisterNetEvent('pixa_menu:OpenKluczeMenu')
AddEventHandler('pixa_menu:OpenKluczeMenu', function()
    ESX.UI.Menu.CloseAll()
    ExecuteCommand( "klucze" )
end)

RegisterNetEvent('pixa_menu:OpenKluczeMenu')
AddEventHandler('pixa_menu:OpenKluczeMenu', function()
    ESX.UI.Menu.CloseAll()
    ExecuteCommand( "klucze" )
end)



RegisterNetEvent('pixa_menu:PrzednieLewe')
AddEventHandler('pixa_menu:PrzednieLewe', function(entity)
    if GetVehicleDoorAngleRatio(entity,0) == 0 then
        SetVehicleDoorOpen(entity,0,0,0)
      else
        SetVehicleDoorShut(entity,0,0,0)
      end
end)

RegisterNetEvent('pixa_menu:PrzedniePrawe')
AddEventHandler('pixa_menu:PrzedniePrawe', function(entity)
    if GetVehicleDoorAngleRatio(entity,1) == 0 then
        SetVehicleDoorOpen(entity,1,0,0)
      else
        SetVehicleDoorShut(entity,1,0,0)
      end
end)


RegisterNetEvent('pixa_menu:TylnieLewe')
AddEventHandler('pixa_menu:TylnieLewe', function(entity)
    if GetVehicleDoorAngleRatio(entity,2) == 0 then
        SetVehicleDoorOpen(entity,2,0,0)
      else
        SetVehicleDoorShut(entity,2,0,0)
      end
end)

RegisterNetEvent('pixa_menu:TylniePrawe')
AddEventHandler('pixa_menu:TylniePrawe', function(entity)
    if GetVehicleDoorAngleRatio(entity,3) == 0 then
        SetVehicleDoorOpen(entity,3,0,0)
      else
        SetVehicleDoorShut(entity,3,0,0)
      end
end)

RegisterNetEvent('pixa_menu:Bagaznik')
AddEventHandler('pixa_menu:Bagaznik', function(entity)
    if GetVehicleDoorAngleRatio(entity,5) == 0 then
        SetVehicleDoorOpen(entity,5,0,0)
      else
        SetVehicleDoorShut(entity,5,0,0)
      end
end)

RegisterNetEvent('pixa_menu:Maska')
AddEventHandler('pixa_menu:Maska', function(entity)
    if GetVehicleDoorAngleRatio(entity,4) == 0 then
        SetVehicleDoorOpen(entity,4,0,0)
      else
        SetVehicleDoorShut(entity,4,0,0)
      end
end)








function GetPlayerFromPed(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end