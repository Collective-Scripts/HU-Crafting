fx_version 'cerulean'
games { 'rdr3', 'gta5' }
author 'Collective'
description 'A simple crafting system for ox_inventory'
version '1.1'
lua54 'yes'
shared_scripts{
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}
client_scripts{
    'config.lua',
    'modules/cl_notify.lua',
    'modules/utils.lua',
    'client/main.lua'
}
server_scripts{
    'config.lua',
    'modules/sv_notify.lua',
    'server/main.lua'
}