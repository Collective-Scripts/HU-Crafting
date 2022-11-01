local SpawnedTables = {}

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function createProp(prop)
    local ped = PlayerPedId()
    lib.requestModel(prop.model)
    local coords = GetEntityCoords(ped)
    local object = CreateObject(prop.model, coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, prop.bone or 60309), prop.pos.x, prop.pos.y, prop.pos.z, prop.rot.x, prop.rot.y, prop.rot.z, true, true, false, true, 0, true)
    return object
end

function anim(data)
    local ped = PlayerPedId()
    lib.requestAnimDict(data.dict)
    TaskPlayAnim(ped, data.dict, data.clip, data.blendIn or 3.0, data.blendOut or 1.0, data.duration or -1, data.flag or 49, data.playbackRate or 0, data.lockX, data.lockY, data.lockZ)
end

function spawnTable(data)
    lib.requestModel(data.prop)
    local newTable = CreateObject(GetHashKey(data.prop), data.pos.x, data.pos.y, data.pos.z, false, false, false)
    SetEntityHeading(newTable, data.pos.w)
    FreezeEntityPosition(newTable, true)
    SpawnedTables[data.id] = newTable
end

function DespawnTable(id)
    local obj = SpawnedTables[id]
    DeleteObject(obj)
    DeleteEntity(obj)
    SpawnedTables[id] = nil
end
  

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end 
    for k, v in pairs(SpawnedTables) do
        DeleteObject(v)
        DeleteEntity(v)
    end
end)
  
function startMinigame(data)
    local ped = PlayerPedId()
    local createObject = createProp({model = data.model, pos = data.pos, rot = data.rot, bone = data.bone})
    anim({dict = data.dict, clip = data.clip, flag = data.flag})
    local returnValue = lib.skillCheck(data.game)
    if not returnValue then
        DeleteObject(createObject)
        DeleteEntity(createObject)
        ClearPedTasks(ped)
    end
    if returnValue then
        DeleteObject(createObject)
        DeleteEntity(createObject)
        ClearPedTasks(ped)
    end
    return returnValue
end

function loadProp(data)
    RequestModel(data.output_object)
    while not HasModelLoaded(data.output_object) do
        Wait(0)
    end
    local object = CreateObject(data.hash, data.pos.x, data.pos.y, data.pos.z, true, true, true)
    SetEntityHeading(object, data.heading)
    return object
end