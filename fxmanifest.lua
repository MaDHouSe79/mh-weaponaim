--[[ ===================================================== ]] --
--[[            MH Weapon Aim Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
fx_version 'cerulean'
games {'gta5'}

author 'MaDHouSe'
description 'mh-weaponaim'
version '2.0'

shared_scripts {
    '@qb-core/shared/locale.lua',  
    --'locales/en.lua', -- change en to your language   
    --'config.lua', 
}

client_scripts {'client/main.lua'}

server_scripts {'@oxmysql/lib/MySQL.lua', 'server/main.lua', 'server/update.lua'}

dependencies {'oxmysql', 'qb-core'}

lua54 'yes'
