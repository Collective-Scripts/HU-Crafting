CollectiveC = {}
function CollectiveC.Notification(theType, message)
    if Config.NotificationType.client == 'mythic_notify_default' then
        if theType == 1 then
            exports['mythic_notify']:SendAlert('success', message, 5000)
        elseif theType == 2 then
            exports['mythic_notify']:SendAlert('inform', message, 5000)
        elseif theType == 3 then
            exports['mythic_notify']:SendAlert('error', message, 5000)
        end
    elseif Config.NotificationType.client == 'mythic_notify_old' then
        if theType == 1 then
            exports['mythic_notify']:DoCustomHudText('success', message, 5000)
        elseif theType == 2 then
            exports['mythic_notify']:DoCustomHudText('inform', message, 5000)
        elseif theType == 3 then
            exports['mythic_notify']:DoCustomHudText('error', message, 5000)
        end
    elseif Config.NotificationType.client == 'ox_lib' then
        if GetResourceState('ox_lib') == 'started' then
            if theType == 1 then
                lib.notify({title = 'Crafting', description = message, type = 'success', duration = 5000})
            elseif theType == 2 then
                lib.notify({title = 'Crafting', description = message, type = 'inform', duration = 5000})
            elseif theType == 3 then
                lib.notify({title = 'Crafting', description = message, type = 'error', duration = 5000})
            end
        end
    elseif Config.NotificationType.client == 't-notify' then
        if theType == 1 then
            exports['t-notify']:Custom({style = 'success', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 2 then
            exports['t-notify']:Custom({style = 'info', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 3 then
            exports['t-notify']:Custom({style = 'error', duration = 5000, title = 'Crafting', message = message, sound = false})
        end
    elseif Config.NotificationType.client == 'col_notify' then
        if theType == 1 then
            exports['col_notify']:Custom({style = 'success', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 2 then
            exports['col_notify']:Custom({style = 'info', duration = 5000, title = 'Crafting', message = message, sound = false})
        elseif theType == 3 then
            exports['col_notify']:Custom({style = 'error', duration = 5000, title = 'Crafting', message = message, sound = false})
        end
    elseif Config.NotificationType.client == 'Roda_Notifications' then
        if theType == 1 then
            exports['Roda_Notifications']:showNotify(message, 'success', 5000)
        elseif theType == 2 then
            exports['Roda_Notifications']:showNotify(message, 'info', 5000)
        elseif theType == 3 then
            exports['Roda_Notifications']:showNotify(message, 'error', 5000)
        end
    elseif Config.NotificationType.client == 'esx_notify' then
        if theType == 1 then
            exports["esx_notify"]:Notify('success', 5000, message)
        elseif theType == 2 then
            exports["esx_notify"]:Notify('info', 5000, message)
        elseif theType == 3 then
            exports["esx_notify"]:Notify('error', 5000, message)
        end
    elseif Config.NotificationType.client == 'col_notify_new' then
        if theType == 1 then
            exports["col_notify"]:Notify('success', 5000, message, 'Crafting')
        elseif theType == 2 then
            exports["col_notify"]:Notify('info', 5000, message, 'Crafting')
        elseif theType == 3 then
            exports["col_notify"]:Notify('error', 5000, message, 'Crafting')
        end
    elseif Config.NotificationType.client == 'default-esx' then
        if theType == 1 or theType == 2 or theType == 3 then
            SetNotificationTextEntry('STRING')
            AddTextComponentString(message)
            DrawNotification(0,1)
        end
    elseif Config.NotificationType.client == 'okokNotify' then
        if theType == 1 then
            exports['okokNotify']:Alert("Crafting", message, 5000, 'success')
        elseif theType == 2 then
            exports['okokNotify']:Alert("Crafting", message, 5000, 'info')
        elseif theType == 3 then
            exports['okokNotify']:Alert("Crafting", message, 5000, 'error')
        end

    elseif Config.NotificationType.client == 'custom' then
        if theType == 1 then
            -- Your Notification
        elseif theType == 2 then
            -- Your Notification
        elseif theType == 3 then
            -- Your Notification
        end
    end
end
