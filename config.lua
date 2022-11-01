Config = {}

Config.NotificationType = { --['mythic_notify_default', 'mythic_notify_old', 'ox_lib', 't-notify', 'col_notify', 'col_notify_new', 'Roda_Notifications' 'esx_notify', 'default-esx']--
	client = 'ox_lib',
    server = 'ox_lib'
} 

Config.Crafting = {
    [1] = {
        CraftData = {
            CraftLabel = '[~r~E~w~] Crafting',
            craft_table = 'gr_prop_gr_bench_04a', -- [If you want to disable this feature, set this to false.]-
            craft_table_coords = vec4(735.7, -1081.41, 22.17, 270.0),
            CraftName = 'Weapon Crafting',
            CraftID = 'weapon_crafting', --[Please change this if you used ox_lib.]--
            ContextMenu = 'esx_context', --[esx_context, ox_lib]--
            Craft = {
                [1] = {
                    craft_time = 5000, -- [Change this if you use 'ox-circle' or 'ox-progress'.]
                    craft_type = 'ox-progress', -- [ox-skillbar, ox-circle, ox-progress]--
                    craft_type_data = {'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'hard'}, -- [If you use 'ox-skillbar,' change this. / https://overextended.github.io/docs/ox_lib/Interface/Client/skillcheck]
                    craft_anim = {
                        dict = 'mini@repair',
                        clip = 'fixing_a_ped',
                        flag = 49,
                        heading = 270.0
                    }, 
                    craft_object = {
                        output_object = 'w_ar_carbinerifle', -- [https://forge.plebmasters.de/objects]--
                        attach_object = `prop_tool_screwdvr02`,
                        attach_pos = vec3(0.14, 0.0, -0.01),
                        attach_rot = vec3(60.0, -147.0, 30.0),
                        attach_bone = 57005
                    },
                    output_item = 'weapon_carbinerifle', 
                    output_qyt = 1, 
                    output_image = 'https://media.discordapp.net/attachments/1035636469626327110/1035636701948817490/WEAPON_CARBINERIFLE.png',
                    output_label = 'Carbine Rifle',
                    input_items = {
                        {item = 'rocks', value = 5, label = 'Rocks'},
                        {item = 'iron', value = 1, label = 'Iron'},
                    },
                },
                -- [2] = {
                --     input_items = {
                --         {item = 'gold', value = 1, label = 'Gold'},
                --         {item = 'diamond', value = 1, label = 'Diamond'},
                --     },
                --     output_item = 'weapon_pistol', 
                --     output_qyt = 1, 
                --     output_image = 'https://media.discordapp.net/attachments/1035636469626327110/1035636842139230208/WEAPON_PISTOL.png',
                --     output_label = 'Pistol'
                -- }
                -- [2] = {
                --     item = 'weapon_pistol', 
                --     qyt = 1, 
                --     label = 'Pistol'
                -- },
                -- [3] = {
                --     item = 'weapon_pistol50', 
                --     qyt = 1, 
                --     label = 'Pistol 50'
                -- }
            }
        }
    }
}