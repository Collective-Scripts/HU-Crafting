CollectiveS = {}
function CollectiveS.Notification(_source, theType, message)
    if Config.NotificationType.server == 'mythic_notify_default' then
        if theType == 1 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = message, length = 5000})
        elseif theType == 2 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = message, length = 5000})
        elseif theType == 3 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = message, length = 5000})
        end
        
    elseif Config.NotificationType.server == 'mythic_notify_old' then
        if theType == 1 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = message, length = 5000})
        elseif theType == 2 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = message, length = 5000})
        elseif theType == 3 then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = message, length = 5000})
        end
    elseif Config.NotificationType.server == 'ox_lib' then
        if GetResourceState('ox_lib') == 'started' then
            if theType == 1 then
                TriggerClientEvent('ox_lib:notify', _source, {type = 'success', description = message})
            elseif theType == 2 then
                TriggerClientEvent('ox_lib:notify', _source, { type = 'inform', description = message})
            elseif theType == 3 then
                TriggerClientEvent('ox_lib:notify', _source, {type = 'error', description = message})
            end
        end
    elseif Config.NotificationType.server == 't-notify' then
        if theType == 1 then
            TriggerClientEvent('t-notify:client:Custom', _source, {style = 'success', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 2 then
            TriggerClientEvent('t-notify:client:Custom', _source, {style = 'info', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 3 then
            TriggerClientEvent('t-notify:client:Custom', _source, {style = 'error', duration = 5000, title = 'Crafting', message = message, sound = false})
        end
    elseif Config.NotificationType.server == 'col_notify' then
        if theType == 1 then
            TriggerClientEvent('col_notify:client:Custom', _source, {style = 'success', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 2 then
            TriggerClientEvent('col_notify:client:Custom', _source, {style = 'info', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 3 then
            TriggerClientEvent('col_notify:client:Custom', _source, {style = 'error', duration = 5000, title = 'Crafting', message = message, sound = false})
        end
    elseif Config.NotificationType.server == 'Roda_Notifications' then
        if theType == 1 then
            TriggerClientEvent('Roda_Notifications:showNotification', _source, message, 'success', 5000)
        elseif theType == 2 then
            TriggerClientEvent('Roda_Notifications:showNotification', _source, message, 'info', 5000)
        elseif theType == 3 then
            TriggerClientEvent('Roda_Notifications:showNotification', _source, message, 'error', 5000)
        end
    elseif Config.NotificationType.server == 'esx_notify' then
        if theType == 1 then
            TriggerClientEvent("ESX:Notify", _source, "success", 5000, "message here")
        elseif theType == 2 then
            TriggerClientEvent("ESX:Notify", _source, "info", 5000, "message here")
        elseif theType == 3 then
            TriggerClientEvent("ESX:Notify", _source, "error", 5000, "message here")
        end
    elseif Config.NotificationType.server == 'col_notify_new' then
        if theType == 1 then
            TriggerClientEvent('col_notify:Notify', _source, 'success', 5000, message, 'Crafting')
        elseif theType == 2 then
            TriggerClientEvent('col_notify:Notify', _source, 'info', 5000, message, 'Crafting')
        elseif theType == 3 then
            TriggerClientEvent('col_notify:Notify', _source, 'error', 5000, message, 'Crafting')
        end
    elseif Config.NotificationType.server == 'default-esx' then
        if theType == 1 or theType == 2 or theType == 3 then
            TriggerClientEvent('esx:showNotification', _source, message)
        end
    elseif Config.NotificationType.server == 'okokNotify' then
        if theType == 1 then
            TriggerClientEvent('okokNotify:Alert', _source, "Crafting", message, 5000, 'success')
        elseif theType == 2 then
            TriggerClientEvent('okokNotify:Alert', _source, "Crafting", message, 5000, 'info')
        elseif theType == 3 then
            TriggerClientEvent('okokNotify:Alert', _source, "Crafting", message, 5000, 'error')
        end
    elseif Config.NotificationType.server == 'custom' then
        if theType == 1 then
            -- Your Notification
        elseif theType == 2 then
            -- Your Notification
        elseif theType == 3 then
            -- Your Notification
        end
    end
end