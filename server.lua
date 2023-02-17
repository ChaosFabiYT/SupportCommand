local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterServerEvent('Chaos:callSupport')
AddEventHandler('Chaos:callSupport', function(message, location)
    local xPlayerSender = ESX.GetPlayerFromId(source)

    for k, playerID in pairs(GetPlayers()) do
        local xPlayerTarget = ESX.GetPlayerFromId(playerID)
        local targetGroup = xPlayerTarget.getGroup()

        if targetGroup == 'admin' or targetGroup == 'superadmin' or targetGroup == 'moderator' then
            TriggerClientEvent('Chaos:showSupport', xPlayerTarget.source, xPlayerSender.name, xPlayerSender.source, message, location)
        end
    end

end)