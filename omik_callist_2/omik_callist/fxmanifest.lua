--[[
#########################################################
# ██████╗ ███╗   ███╗██╗██╗  ██╗██╗  ██╗███████╗██╗     #
#██╔═══██╗████╗ ████║██║██║ ██╔╝██║ ██╔╝██╔════╝██║     #
#██║   ██║██╔████╔██║██║█████╔╝ █████╔╝ █████╗  ██║     #
#██║   ██║██║╚██╔╝██║██║██╔═██╗ ██╔═██╗ ██╔══╝  ██║     #
#╚██████╔╝██║ ╚═╝ ██║██║██║  ██╗██║  ██╗███████╗███████╗#
# ╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝#
#########################################################
--]]
-- Script: omik_callist V2
-- Author: OMikkel#3217

fx_version "cerulean"
game "gta5"

name 'omik_callist'
author 'OMikkel#3217 - https://omikkel.com/ - https://omikkel.com/discord'
description 'omik_callist_V2 | Lavet af OMikkel#3217 - https://omikkel.com/'

version "2.1.6"

dependencies {
    "mysql-async"
}
 

server_scripts {
    "lib/sCallback.lua",
    "@vrp/lib/utils.lua",
    "@mysql-async/lib/MySQL.lua",
    'licensekey.lua',
    'config.lua',
    'server.lua'
    "assets/*.lua"
}
client_script {
    "lib/cCallback.lua",
    'config.lua',
    'client.lua'
}

files {
    "assets/notification.ogg",
    "assets/logo.png"
}

ui_page 'https://callist.omikkel.com/'