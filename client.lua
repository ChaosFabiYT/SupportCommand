ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- /support arg1 arg2 arg3
RegisterCommand("support", function(source, args, rawCommand)

    local message = ''
    for i=1, #args, 1 do
        message = message .. ' ' .. args[i]
    end

    local playerPed = PlayerPedId()
    local playerLocation = GetEntityCoords(playerPed)

    TriggerServerEvent('Chaos:callSupport', message, playerLocation)

end)

RegisterNetEvent('Chaos:showSupport')
AddEventHandler('Chaos:showSupport', function(playername, playerid, message, location)
    
    ESX.ShowNotification('~r~Supportfall!\n~y~' .. playername .. ' ~s~(~y~' .. playerid .. '~s~) benötigt Hilfe. \nNachricht: ~b~' .. message)

    local time = 0
    while time < 800 do
        time = time + 1
        showInfobar('Drücke ~g~E~s~, um dich zu ~y~' .. playername .. ' ~s~zu teleportieren.')
        if IsControlJustReleased(0, 38) then
            SetEntityCoords(PlayerPedId(), location.x, location.y, location.z + 1.0)
            time = 800
            RemoveBlip(blip)
        elseif IsControlJustReleased(0, 47) then
            break
        end 

        Citizen.Wait(1)
    end
end)

function showInfobar(msg)

    CurrentActionMsg  = msg
    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end