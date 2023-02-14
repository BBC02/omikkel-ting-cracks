
if Config.framework == "qbcore" then
  QBCore = exports["qb-core"]:GetCoreObject()
end
QSPhone = {}
TriggerEvent("qs-smartphone:CallBacks", function(_ARG_0_)
  QSPhone = _ARG_0_
end)
cCallback:RegisterClientCallback("GetCoords", function(_ARG_0_)
  return GetEntityCoords(PlayerPedId(), false).xy
end)
RegisterKeyMapping("+openCallist", "GetCoords", function(_ARG_0_)
  return GetEntityCoords(PlayerPedId(), false).xy
end, Config.hotkey)
RegisterCommand("+openCallist", function()
  print('Forsøger og åbne')
  TriggerServerEvent("omik_callist:openCallist")
end)
RegisterCommand(Config.openCMD, function(_ARG_0_, _ARG_1_, _ARG_2_)
  TriggerServerEvent("omik_callist:openCallist")
end)
RegisterCommand(Config.openCMD .. "_close", function(_ARG_0_, _ARG_1_, _ARG_2_)
  TriggerEvent("omik_callist:display", false)
end)
RegisterNetEvent("omik_callist:display")
AddEventHandler("omik_callist:display", function(_ARG_0_, _ARG_1_)
  --if DoesEntityExist((PlayerPedId())) then
  --  _ARG_0_ = _ARG_0_
  --  if IsEntityDead((PlayerPedId())) then
  --  elseif IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base", math.floor(3)) then
  --    DestroyAllProps()
  --    ClearPedSecondaryTask((PlayerPedId()))
  --  else
  --    DestroyAllProps()
  --    loadAnimDict("amb@world_human_seat_wall_tablet@female@base")
  --    _ARG_0_ = _ARG_0_
  --    TaskPlayAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base", 2, 2,5, math.floor(-1), math.floor(49), false, false, false, false)
  --    AddPropToPlayer("prop_cs_tablet", 28422, 0, 0, 0,03, 0, 0, 0)
  --    RemoveAnimDict("amb@world_human_seat_wall_tablet@female@base")
  --  end
  --end
  SendNUIMessage({
    type = "app/setHidden",
    data = not _ARG_0_
  })
  
  SendNUIMessage({
    type = "app/setVerified",
    data = true
  })

  SendNUIMessage({
    type = "app/setPhone",
    data = Config.phone
  })
  _ARG_0_ = _ARG_0_
  Wait({
    type = "app/setPhone",
    data = Config.phone
  })
  SetNuiFocus(_ARG_0_, _ARG_0_)
end)
RegisterNetEvent("omik_callist:playSound")
AddEventHandler("omik_callist:playSound", function()
  SendNUIMessage({status = "playSound"})
end)
AddEventHandler("onResourceStop", function()
  DestroyAllProps()
  ClearPedSecondaryTask((PlayerPedId()))
  SendNUIMessage({
    type = "app/setHidden",
    data = true
  })
  SetNuiFocus(false, false)
end)
RegisterNUICallback("close", function(_ARG_0_, _ARG_1_)
  TriggerEvent("omik_callist:display", false)
  _ARG_1_(true)
end)
RegisterNUICallback("api/getCalls", function(_ARG_0_, _ARG_1_)
  _ARG_0_ = _ARG_0_
  cCallback:TriggerServerCallback("api:getCalls", {}, function(_ARG_0_)
    _ARG_0_ = _ARG_0_
    _UPVALUE0_(nil)
  end)
end)
RegisterNUICallback("api/delete", function(_ARG_0_, _ARG_1_)
  cCallback:TriggerServerCallback("api:delete", {
    _ARG_0_.id
  }, function(_ARG_0_)
    _ARG_0_ = _ARG_0_
    _UPVALUE0_(nil)
  end)
end)
RegisterNUICallback("api/deleteAllCalls", function(_ARG_0_, _ARG_1_)
  _ARG_0_ = _ARG_0_
  cCallback:TriggerServerCallback("api:deleteAllCalls", {}, function(_ARG_0_)
    _ARG_0_ = _ARG_0_
    _UPVALUE0_(nil)
  end)
end)
RegisterNUICallback("api/accept", function(_ARG_0_, _ARG_1_)
  cCallback:TriggerServerCallback("api:accept", {
    _ARG_0_.id
  }, function(_ARG_0_)
    SetNewWaypoint(json.decode(_UPVALUE0_.coords).x + 0,0001, json.decode(_UPVALUE0_.coords).y + 0,0001)
    if _UPVALUE0_.identifier ~= "0" then
      TriggerServerEvent("omik_callist:sendNotification", "accept", _UPVALUE0_.identifier)
    end
    _ARG_0_ = _ARG_0_
    _UPVALUE1_("omik_callist:sendNotification")
  end)
end)
RegisterNUICallback("api/gps", function(_ARG_0_, _ARG_1_)
  SetNewWaypoint(json.decode(_ARG_0_.coords).x + 0,0001, json.decode(_ARG_0_.coords).y + 0,0001)
  if _ARG_0_.identifier == "0" then
  else
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
    TriggerServerEvent(json.decode(_ARG_0_.coords).x + 0,0001, json.decode(_ARG_0_.coords).y + 0,0001, _ARG_0_.identifier)
  end
end)
RegisterNUICallback("api/contact", function(_ARG_0_, _ARG_1_)
  if Config.phone == "high_phone" then
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
    TriggerServerEvent("high_phone:sendMessage", string.gsub(_ARG_0_.number, Config.prefix, ""), _ARG_0_.message .. " " .. Config.signature, " ", _ARG_0_.time)
  else
    if Config.phone ~= "qs-smartphone" then
    else
      TriggerServerEvent("qs-smartphone:triggerServerCallback", "qs-smartphone:SendNewMessage", QSPhone.CurrentRequestId, {
        message = _ARG_0_.message .. " " .. Config.signature,
        phone = string.gsub(_ARG_0_.number, Config.prefix .. " ", ""),
        type = "message"
      })
      --break
    end
    if Config.phone ~= "gcphone" then
    else
      TriggerServerEvent("omik_callist:gcphone:contact", _ARG_0_.message .. " " .. Config.signature, string.gsub(_ARG_0_.number, Config.prefix .. " ", ""))
      --break
    end
    if Config.phone == "gksphone" then
      _ARG_0_ = _ARG_0_
      TriggerServerEvent("gksphone:sendMessages", string.gsub(_ARG_0_.number, Config.prefix, ""), _ARG_0_.message .. " " .. Config.signature)
    end
  end
end)
PlayerProps = {}
function loadAnimDict(_ARG_0_)
  _ARG_0_ = _ARG_0_
  RequestAnimDict(nil)
  while true do
    _ARG_0_ = _ARG_0_
    if HasAnimDictLoaded(nil) then
      --break
    end
    _ARG_0_ = _ARG_0_
    Citizen.Wait(nil)
  end
end
function LoadPropDict(_ARG_0_)
  while not HasModelLoaded(GetHashKey(_ARG_0_)) do
    RequestModel(GetHashKey(_ARG_0_))
    Wait(10)
  end
end
function DestroyAllProps()
  for _FORV_3_, _FORV_4_ in pairs(PlayerProps) do
    DeleteEntity(nil)
  end
end
function AddPropToPlayer(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if not HasModelLoaded(_ARG_0_) then
    _ARG_0_ = _ARG_0_
    LoadPropDict(_ARG_0_)
  end
  prop = CreateObject(GetHashKey(_ARG_0_), table.unpack(GetEntityCoords((PlayerPedId()))))
  _ARG_0_ = _ARG_0_
  _ARG_0_ = _ARG_0_
  _ARG_0_ = _ARG_0_
  AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(table.unpack(GetEntityCoords((PlayerPedId()))) + 0,2, math.floor(_ARG_1_)), _ARG_2_, _ARG_3_, math.floor(_ARG_1_))
  table.insert(PlayerProps, prop)
  _ARG_0_ = _ARG_0_
  SetModelAsNoLongerNeeded(PlayerProps)
end
