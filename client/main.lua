local ox_inventory = exports.ox_inventory
local isCrafting = false
local libLoaded = false

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

local function HasItem(table)
    for k,v in pairs(table) do
        local hasitem = ox_inventory:Search('count', v.item)
        if hasitem < v.value then
            CollectiveC.Notification(3, 'You must have '..v.value..'x '..ox_inventory:Items()[v.item].label..' to proceed with this action')
            return false
        end
    end
    return true
end

AddEventHandler('HU-Crafting:Craft', function(data)
    local context = data.context
    local method = data.method
    if context == 'ox_lib' then
    
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
                    heading = data.craft_table_coords,
                    craft_table_coords = data.craft_table_coords,
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
    elseif method == 'craft' then
        ESX.CloseContext()
        if HasItem(data.input_items) then
            local success = false
            isCrafting = true
            local createObject = loadProp({
                output_object = data.craft_object.output_object,
                pos = vec3(data.craft_table_coords.x, data.craft_table_coords.y, data.craft_table_coords.z - 0.1),
                hash = GetHashKey(data.craft_object.output_object),
                heading = data.craft_anim.heading
            })
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
                DeleteObject(createObject)
                return
            end
            if success then
                isCrafting = false
                DeleteObject(createObject)
            end
        end
    end
end)

function onEnter(self)
    spawnTable({
        prop = self.prop,
        pos = vec4(self.pos.x, self.pos.y, self.pos.z - 2.2, self.pos.w),
        id = self.key
    })
end

function onExit(self)
    DespawnTable(self.key)
end

CreateThread(function()
    for i = 1, #Config.Crafting do
        local data = Config.Crafting[i]
        if data.CraftData.craft_table then
            local box = lib.zones.box({
                coords = vec3(data.CraftData.craft_table_coords.x, data.CraftData.craft_table_coords.y, data.CraftData.craft_table_coords.z),
                size = vec3(10, 10, 5),
                rotation = data.CraftData.craft_table_coords.w,
                debug = false,
                onEnter = onEnter,
                onExit = onExit,
                prop = data.CraftData.craft_table,
                pos = data.CraftData.craft_table_coords,
                key = i
            })
        end
    end
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i = 1, #Config.Crafting do
            local data = Config.Crafting[i]
            local dist = #(coords - vec3(data.CraftData.craft_table_coords.x, data.CraftData.craft_table_coords.y, data.CraftData.craft_table_coords.z))
            if dist <= 2.0 and not isCrafting then
                sleep = 0
                DrawText3D(data.CraftData.craft_table_coords.x, data.CraftData.craft_table_coords.y, data.CraftData.craft_table_coords.z + 0.2, data.CraftData.CraftLabel)
                if IsControlJustReleased(0, 38) then
                    Craft(data.CraftData)
                end
            end
        end
        Wait(sleep)
    end
end)