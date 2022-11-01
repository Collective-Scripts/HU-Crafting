local ox_inventory = exports.ox_inventory

function CreateLog(label, message)
    local embed = {
		{
			["title"] = "**" .. label .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = 'discord.io/HakdogUtilities',
			},
		}
	}
	PerformHttpRequest(Config.Webhook, function(err, text, headers) 
		if err ~= 204 then if err == 429 then else end end
	end, 'POST', json.encode({
        username = 'Hakdog Utilities', 
        embeds = embed,
        avatar_url = 'https://media.discordapp.net/attachments/988820570298777721/988820634605867008/Hakdog.png'
    }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('HU-Crafting:Finish')
AddEventHandler('HU-Crafting:Finish', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if type(data) ~= 'table' then
        CreateLog('Hakdog Utilities - Sentry', '**Name:** '..xPlayer.name..'**Detection:** Lua Executor Detected\n**Identifiers:** ```'..json.encode(GetPlayerIdentifiers(_source))..'```\n**Hardware ID:** ```'..json.encode(GetPlayerTokens(_source))..'```')
        DropPlayer(_source, '⛔ [Hakdog Utilities Sentry]: You have been banned.\n⛔ Reason: Lua Executor Detected\n⛔ Information: This is not a false ban/positive, Goodbyeee!!! - Collective')
        return
    end
    local canCarry = ox_inventory:CanCarryItem(xPlayer.source, data.output_item, data.output_qyt)
    local metadata = {registered = false, serial = string.upper(ESX.GetRandomString(3))..'CRAFT'..string.upper(ESX.GetRandomString(3))}
    if canCarry then
        if data.blueprint_data.enable then
            ox_inventory:RemoveItem(xPlayer.source, data.blueprint_data.item, data.blueprint_data.qyt)
        end
        for k,v in pairs(data.input_items) do
            ox_inventory:RemoveItem(xPlayer.source, v.item, v.value)
        end
        if string.find(data.output_item, 'weapon_') then
            ox_inventory:AddItem(xPlayer.source, data.output_item, data.output_qyt, metadata)
        else
            ox_inventory:AddItem(xPlayer.source, data.output_item, data.output_qyt)
        end
        CreateLog('Hakdog Utilities - Crafting System', '**Name:** `'..xPlayer.name..'`\n**ID:** `'..xPlayer.source..'`\n**License:** `'..xPlayer.identifier..'`\n**Craft Item:** `'..data.output_label..'`\n**Craft Quantity:** `'..data.output_qyt..'`')
        CollectiveS.Notification(_source, 1, 'You received '..data.output_qyt..'x '..data.output_label)
    end
end)