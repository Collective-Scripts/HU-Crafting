local ox_inventory = exports.ox_inventory
local isInZone, libLoaded, isCrafting, Key = false, false, false, nil

if GetResourceState('ox_lib') == 'started' then
    libLoaded = true
end

local function Craft(data)
    local SendMenu = {}
    if data.ContextMenu == 'ox_lib' then
        for i = 1, #data.Craft do
            local theData = data.Craft[i] 
            table.insert(SendMenu,{
                title = theData.output_label,
                description = 'Requirements',
                event = 'HU-Crafting:Craft',
                arrow = true,
                image = theData.output_image,
                metadata = theData.input_items,
                args = {
                    context = data.ContextMenu,
                    heading = data.craft_table_coords,
                    blueprint_data = theData.blueprint_data,
                    craft_table = data.craft_table,
                    craft_table_coords = data.craft_table_coords,
                    craft_time = theData.craft_time,
                    craft_type = theData.craft_type,
                    craft_type_data = theData.craft_type_data,
                    craft_anim = theData.craft_anim,
                    input_items = theData.input_items,
                    output_item = theData.output_item,
                    output_qyt = theData.output_qyt,
                    output_label = theData.output_label,
                    craft_object = theData.craft_object
                }
            })
        end
        lib.registerContext({
            id = data.CraftID,
            title = data.CraftName,
            options = SendMenu
        })
        lib.showContext(data.CraftID)
    elseif data.ContextMenu == 'esx_context' then
        local SendMenu = {
            {
                unselectable=true,
                icon = "fa-solid fa-briefcase",
                title = data.CraftName,
            },
        }
        for i = 1, #data.Craft do
            local theData = data.Craft[i] 
            table.insert(SendMenu,{
                icon="fa-solid fa-box",
                title = theData.output_label,
                description = 'Requirements',
                event = 'HU-Crafting:Craft',
                args = {
                    context = data.ContextMenu,
                    heading = data.craft_table_coords,
                    blueprint_data = theData.blueprint_data,
                    craft_table = data.craft_table,
                    craft_table_coords = data.craft_table_coords,
                    craft_time = theData.craft_time,
                    craft_type = theData.craft_type,
                    craft_type_data = theData.craft_type_data,
                    craft_anim = theData.craft_anim,
                    input_items = theData.input_items,
                    output_item = theData.output_item,
                    output_qyt = theData.output_qyt,
                    output_label = theData.output_label,
                    craft_object = theData.craft_object
                }
            })
        end
        ESX.OpenContext("right" , SendMenu, function(menu, element) -- On Select Function
            TriggerEvent(element.event, element.args)
        end)
    end
end

local function HasItem(table, blueprint)
    for k,v in pairs(table) do
        local hasitem = ox_inventory:Search('count', v.item)
        if hasitem < v.value then
            CollectiveC.Notification(3, 'You must have '..v.value..'x '..ox_inventory:Items()[v.item].label..' to proceed with this action')
            return false
        end
    end
    if blueprint.enable then
        local hasBlueprint = ox_inventory:Search('count', blueprint.item)
        if hasBlueprint < blueprint.qyt then
            CollectiveC.Notification(3, 'You must have '..blueprint.qyt..'x '..ox_inventory:Items()[blueprint.item].label..' to proceed with this action')
            return false
        end
    end
    return true
end

AddEventHandler('HU-Crafting:Craft', function(data)
    local context = data.context
    local method = data.method
    if context == 'ox_lib' then
        lib.registerContext({
            id = 'cfx_hu_craft_option',
            title = '📄 Craft Options',
            options = {
                {
                    title = '🔨 Craft',
                    description = 'Craft this item',
                    event = 'HU-Crafting:Craft',
                    args = {
                        method = 'craft',
                        context = context,
                        heading = data.craft_table_coords,
                        blueprint_data = data.blueprint_data,
                        craft_table_coords = data.craft_table_coords,
                        craft_table = data.craft_table,
                        craft_time = data.craft_time,
                        craft_type = data.craft_type,
                        craft_type_data = data.craft_type_data,
                        craft_anim = data.craft_anim,
                        input_items = data.input_items,
                        output_item = data.output_item,
                        output_qyt = data.output_qyt,
                        output_label = data.output_label,
                        craft_object = data.craft_object
                    }
                },
                {
                    title = '📋 Requirements',
                    description = 'View Requirements',
                    event = 'HU-Crafting:Craft',
                    args = {
                        context = context,
                        method = 'view_craft',
                        input_items = data.input_items
                    }
                }
            },
        })
        lib.showContext('cfx_hu_craft_option')
    elseif context == 'esx_context' then
        local SendMenu = {
            {
                unselectable=true,
                icon = "fa-solid fa-briefcase",
                title = 'Craft Options',
            },
            {
                icon="fa-solid fa-play",
                title = 'Craft',
                description = 'Craft this item',
                event = 'HU-Crafting:Craft',
                args = {
                    method = 'craft',
                    context = context,
                    heading = data.craft_table_coords,
                    craft_table_coords = data.craft_table_coords,
                    blueprint_data = data.blueprint_data,
                    craft_table = data.craft_table,
                    craft_time = data.craft_time,
                    craft_type = data.craft_type,
                    craft_type_data = data.craft_type_data,
                    craft_anim = data.craft_anim,
                    input_items = data.input_items,
                    output_item = data.output_item,
                    output_qyt = data.output_qyt,
                    output_label = data.output_label,
                    craft_object = data.craft_object
                }
            },
            {
                icon="fa-solid fa-boxes-stacked",
                title = 'Requirements',
                description = 'View Requirements',
                event = 'HU-Crafting:Craft',
                args = {
                    context = context,
                    method = 'view_craft',
                    input_items = data.input_items
                }
            }
        }
        ESX.OpenContext("right" , SendMenu, function(menu, element) -- On Select Function
            TriggerEvent(element.event, element.args)
        end)
    end
    if method == 'view_craft' then
        if context == 'esx_context' then
            local SendMenu = {
                {
                    unselectable=true,
                    icon = "fa-regular fa-clipboard",
                    title = 'Requirements',
                },
            }
            for k,v in pairs(data.input_items) do
                table.insert(SendMenu,{
                    icon="fa-solid fa-list",
                    title = v.label..' '..v.value..'x',
                    description = 'Requirement #'..k,
                    disabled=true,
                })
            end
            SendMenu[#SendMenu + 1] = {
                icon="fa-regular fa-circle-xmark",
                title = 'Close',
            }
            ESX.OpenContext("right" , SendMenu, function(menu, element) -- On Select Function
                ESX.CloseContext()
            end)
        elseif context == 'ox_lib' then
            local SendMenu = {}
            for k,v in pairs(data.input_items) do
                table.insert(SendMenu,{
                    title = v.label..' '..v.value..'x',
                    description = 'Requirement #'..k,
                })
            end
            lib.registerContext({
                id = 'cfx_hu_requirements',
                title = '📄 Requirements',
                options = SendMenu
            })
            lib.showContext('cfx_hu_requirements')
        end
    elseif method == 'craft' then
        if context == 'esx_context' then ESX.CloseContext() end
        if HasItem(data.input_items, data.blueprint_data) then
            local success = false
            local createObject = nil
            isCrafting = true
            if data.craft_table then
                createObject = loadProp({
                    output_object = data.craft_object.output_object,
                    pos = vec3(data.craft_table_coords.x, data.craft_table_coords.y, data.craft_table_coords.z - 0.1),
                    hash = GetHashKey(data.craft_object.output_object),
                    heading = data.craft_anim.heading
                })
            end
            SetEntityHeading(PlayerPedId(), data.craft_anim.heading)
            if data.craft_type == 'ox-skillbar' then
                if libLoaded then
                    success = startMinigame({
                        game = data.craft_type_data,
                        dict = data.craft_anim.dict,
                        clip = data.craft_anim.clip,
                        flag = data.craft_anim.flag,
                        model = data.craft_object.attach_object,
                        pos = data.craft_object.attach_pos,
                        rot = data.craft_object.attach_rot,
                        bone = data.craft_object.attach_bone
                    })
                end
            elseif data.craft_type == 'ox-circle' then
                if libLoaded then
                    success = lib.progressCircle({
                        duration = data.craft_time,
                        position = 'middle',
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            car = true,
                            move = true,
                            combat = true
                        },
                        anim = {
                            dict = data.craft_anim.dict,
                            clip = data.craft_anim.clip,
                            flag = data.craft_anim.flag,
                        },
                        prop = {
                            model = data.craft_object.attach_object,
                            pos = data.craft_object.attach_pos,
                            rot = data.craft_object.attach_rot,
                            bone = data.craft_object.attach_bone
                        }
                    })
                end
            elseif data.craft_type == 'ox-progress' then
                if libLoaded then
                    success  = lib.progressBar({
                        duration = data.craft_time,
                        label = 'Crafting '..data.output_label,
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            car = true,
                            move = true,
                            combat = true
                        },
                        anim = {
                            dict = data.craft_anim.dict,
                            clip = data.craft_anim.clip,
                            flag = data.craft_anim.flag,
                        },
                        prop = {
                            model = data.craft_object.attach_object,
                            pos = data.craft_object.attach_pos,
                            rot = data.craft_object.attach_rot,
                            bone = data.craft_object.attach_bone
                        }
                    })
                end
            end
            if not success then
                isCrafting = false
                CollectiveC.Notification(3, 'Failed.')
                if data.craft_table then
                    DeleteObject(createObject)
                end
                return
            end
            if success then
                isCrafting = false
                TriggerServerEvent('HU-Crafting:Finish', {
                    input_items = data.input_items,
                    output_qyt = data.output_qyt,
                    output_item = data.output_item,
                    output_label = data.output_label,
                    blueprint_data = data.blueprint_data
                })
                if data.craft_table then
                    DeleteObject(createObject)
                end
            end
        end
    end
end)

function onEnter(self)
    if self.method == 'table' then
        spawnTable({
            prop = self.prop,
            pos = vec4(self.pos.x, self.pos.y, self.pos.z - 2.2, self.pos.w),
            id = self.key
        })
    elseif self.method == 'text' then
        isInZone = true
        Key = self.key
        if self.text == 'ox_lib' then
            lib.showTextUI('[E] - Craft', {icon = 'fas fa-wrench'})
        elseif self.text == 'ps-ui' then
            exports['ps-ui']:DisplayText("[E] Craft", "primary")
        elseif self.text == 'esx_textui' then
            ESX.TextUI("[E] Craft", "info")
        end
    end
end

function onExit(self)
    if self.method == 'table' then
        DespawnTable(self.key)
    elseif self.method == 'text' then
        isInZone = false
        Key = nil
        if self.text == 'ox_lib' then
            lib.hideTextUI()
        elseif self.text == 'ps-ui' then
            exports['ps-ui']:HideText()
        elseif self.text == 'esx_textui' then
            ESX.HideUI()
        end
    end
end

CreateThread(function()
    for i = 1, #Config.Crafting do
        local data = Config.Crafting[i]
        if data.CraftData.craft_table then
            lib.zones.box({
                coords = vec3(data.CraftData.craft_table_coords.x, data.CraftData.craft_table_coords.y, data.CraftData.craft_table_coords.z),
                size = vec3(10, 10, 5),
                rotation = data.CraftData.craft_table_coords.w,
                debug = false,
                onEnter = onEnter,
                onExit = onExit,
                method = 'table',
                prop = data.CraftData.craft_table,
                pos = data.CraftData.craft_table_coords,
                key = i
            })
            lib.zones.box({
                coords = vec3(data.CraftData.craft_table_coords.x, data.CraftData.craft_table_coords.y, data.CraftData.craft_table_coords.z),
                size = vec3(2, 2.5, 2),
                rotation = data.CraftData.craft_table_coords.w,
                debug = false,
                onEnter = onEnter,
                onExit = onExit,
                method = 'text',
                text = data.CraftData.TextUI,
                key = i
            })
        end
    end
end)

RegisterCommand('craft_system', function()
    if isInZone and not isCrafting then
        Craft(Config.Crafting[Key].CraftData)
    end
end)

RegisterKeyMapping('craft_system', 'Craft System', 'keyboard', 'E')