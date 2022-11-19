------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------
local ent = nil
PlayerData              = {}
local inFocus = false
Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)




------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------


function EnableUI(bool)
  inFocus = bool
  SetNuiFocus(bool, bool)
  SetNuiFocusKeepInput(bool)
  if inFocus then
    SetCursorLocation(0.5, 0.5)
  end
    while inFocus do
      Wait(5)
      DisableAllControlActions(0)
          EnableControlAction(0, 30, true)
          EnableControlAction(0, 31, true)
          EnableControlAction(0, 32, true)
          EnableControlAction(0, 34, true)
          EnableControlAction(0, 21, true)
          EnableControlAction(2, 60, true)
          EnableControlAction(2, 59, true)
          EnableControlAction(2, 64, true)
          EnableControlAction(2, 63, true)
          EnableControlAction(2, 71, true)
          EnableControlAction(2, 72, true)
    end
end

RegisterCommand('resetui', function()
  ESX.UI.Menu.CloseAll()
  SendNUIMessage({
    type = 'close'
  })
  exports['inventory']:CloseUI()
  TriggerEvent('menus:disableFocus')
  EnableUI(false)
end)




function OpenMenu(options, entity, leaveOpenMenu)
  ent = entity
    for i = 1,#options do
      if options[i].shouldDraw ~= nil then
          options[i].drawing = doTest(entity , options[i].shouldDraw )
      end
    end
    local close = true

    if leaveOpenMenu then
      close =  not leaveOpenMenu
    end

  SendNUIMessage({
    type = 'open',
    options = options,
    entity = entity,
    closeMenu = close
  })
  EnableUI(true)
end

-- Toggle focus (Example of Vehcile's menu)
RegisterNUICallback('disablenuifocus', function(data)
  showMenu = data.nuifocus
  inFocus = data.nuifocus
  EnableUI(data.nuifocus)
end)



RegisterNUICallback('useEvent', function(data)

  TriggerEvent(data.event, data.entity)
end)










RegisterCommand('+menu', function()
                ESX.UI.Menu.CloseAll()
                SetCursorLocation(0.5, 0.5)
                OpenMenu(Config.Menus['default_f1'], PlayerPedId())

end, false)

RegisterKeyMapping('+menu', 'Menu~', 'keyboard', 'F1')






function doTest(entity, condition )
  -- inside the string 'test', I would like that any reference to 'trade'
  -- refer to the function parameter instead of a global variable
  if assert(load("local entity = ...; return "..condition))(entity) then
    -- do something
    return true
  end
  return false
end