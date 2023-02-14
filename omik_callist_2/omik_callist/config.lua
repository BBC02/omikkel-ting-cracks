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

Config = {}

Config.framework = "vrp" -- esx // vrp // qbcore
Config.phone = "qb-phone" -- high_phone // qb-phone // gcphone // gksphone // qbus-phone // qs-smartphone // roadphone
Config.esx_event = "esx:getSharedObject" -- esx:getSharedObject // esx:SharedObject1212 // noget helt tredje

Config.databaseless = false -- true = opkald gemmes i et object serverside // false = opkald gemmes i databasen (Du må ikke fjerne mysql-async fra dependencies, det bruges stadig nogle steder!!!)

-- Find hotkeys her https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.hotkey = "F7" 

-- Den command man skriver i chatten for at åbne opkaldslisten.
-- Du kan altid skrive _close efter din command, så fx /calls så vil tabletten lukke, dette er brugbart hvis den bugger.
Config.openCMD = "opkald" 

Config.anonymousCaller = "Ukendt" -- Det der står på opkaldslisten når source er 0
Config.prefix = "+45" -- Dette bliver sat foran telefonnummer i opkaldslisten
Config.signature = "- Politiet" -- Når du kontakter en person igennem opkaldslisten bliver dette tilføjet efter din besked
Config.deleteCallsOnDisconnect = false -- Hvis sat til true, så vil opkaldslisten slette de opkald en person der disconnecter har sendt

Config.GroupType = "job" -- Kun relevant for vrp (  vRP.getUserGroupByType({user_id,Config.GroupType})  )
Config.jobs = { -- Jobs der har adgang til opkaldslisten
    "Politi",
    "EMS",
    "Mekaniker"
}

-- src = player source
-- msg = message
-- service = target job
-- coords = vector2(x, y)
Config.newcall = function(src, msg, service, coords) 
    -- QBCore:
    TriggerClientEvent('QBCore:Notify', src, "Der er kommet et nyt opkald - Åben menuen for at se", "police", 5000)
    -- ESX: 
    -- TriggerClientEvent('esx:showNotification', src, 'Der er kommet et nyt opkald - Åben menuen for at se', "success", 5000)
    -- VRP: 
    -- TriggerClientEvent("pNotify:SendNotification",src, {text = {"Der er kommet et nyt opkald - Åben menuen for at se"}, type = "success", queue = "global", timeout = 5000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end

Config.setgpstext = function(src)
    -- QBCore:
    TriggerClientEvent('QBCore:Notify', src, "En gps blev sat til dit opkald", "police", 5000)
    -- ESX: 
    -- TriggerClientEvent('esx:showNotification', src, 'En gps blev sat til dit opkald', "success", 5000)
    -- VRP: 
    -- TriggerClientEvent("pNotify:SendNotification",src, {text = {"En gps blev sat til dit opkald"}, type = "success", queue = "global", timeout = 5000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end

Config.taketext = function(src)
    -- QBCore:
    TriggerClientEvent('QBCore:Notify', src, "Dit opkald blev taget - Hjælpen er på vej", "police", 5000)
    -- ESX: 
    -- TriggerClientEvent('esx:showNotification', src, 'Dit opkald blev taget - Hjælpen er på vej', "success", 5000)
    -- VRP: 
    -- TriggerClientEvent("pNotify:SendNotification",src, {text = {"Dit opkald blev taget - Hjælpen er på vej"}, type = "success", queue = "global", timeout = 5000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end

return Config