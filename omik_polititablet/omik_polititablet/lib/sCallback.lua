-- LAVET I SAMARBEJDE MED MOHR
-- sCallback.lua og cCallback.lua kan bruges som man vil, dog værdsættes en smule credit, men vigtigst af alt, SÅ SKAL MAN IKKE SÆLGE DET
-- Link: https://github.com/OMikkel/omik_callbacks

sCallback = {
    RegisterServerCallback = function(self, name, f)
        self.server[name] = f
    end,
    TriggerClientCallback = function(self, source, name, args, cb)
        TriggerClientEvent("omik_polititablet:TriggerClientCallback", source, name, args)
        while self.client[name] == nil do
            Wait(1)
        end
        cb(self.client[name])
        self.client[name] = nil
    end,
    server = {},
    client = {}
}
RegisterServerEvent("omik_polititablet:TriggerServerCallback")
AddEventHandler("omik_polititablet:TriggerServerCallback", function(name, args)
    local source = source
    TriggerClientEvent("omik_polititablet:RecieveServerCallback", source, name, sCallback.server[name](source, args))
end)

RegisterServerEvent("omik_polititablet:RecieveClientCallback")
AddEventHandler("omik_polititablet:RecieveClientCallback", function(name, data)
    sCallback.client[name] = data
end)
