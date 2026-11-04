fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'ox_inventory'
author 'Overextended'
version '2.48.0'
repository 'https://github.com/overextended/ox_inventory'
description 'PX Inventory Redesign - custom UI for ox_inventory'
redesign_author 'PX Inventory'
redesign_version '1.0.0'
license 'GPL-3.0-or-later'

dependencies {
    '/server:6116',
    '/onesync',
    'oxmysql',
    'ox_lib',
}

shared_script '@ox_lib/init.lua'

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'init.lua'
}

client_script 'init.lua'
server_scripts {
    'px-inventory/config.lua',
    'px-inventory/server.lua'
}
client_script 'px-inventory/client.lua'

ui_page 'web/build/index.html'

files {
    'client.lua',
    'locales/*.json',
    'web/build/index.html',
    'web/build/assets/*.js',
    'web/build/assets/*.css',
    'web/build/assets/*.woff2',
    'web/build/assets/*.ttf',
    'web/build/assets/*LICENSE.txt',
    'web/build/assets/*.png',
    'web/images/*.png',
    'modules/**/shared.lua',
    'modules/**/client.lua',
    'modules/bridge/**/client.lua',
    'data/*.lua',
}