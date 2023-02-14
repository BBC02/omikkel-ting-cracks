--if _KyQUrgrfOfLH == "This file was protected with MoonSec V3 by Federal#9999" then
--else
--  return
--end
Citizen.CreateThread(function()
  Wait(500)
  SendNUIMessage({
    type = "api_info/setApiInfo",
    data = {
      framework = cfg.framework
    }
  })
end)
RegisterKeyMapping("+openTablet", " omik_polititablet", "keyboard", cfg.hotkey)
RegisterCommand("+openTablet", function()
  print('Command executet')
  TriggerServerEvent("omik_polititablet:openTablet")
end)
RegisterCommand(cfg.openCMD, function(_ARG_0_, _ARG_1_, _ARG_2_)
  TriggerServerEvent("omik_polititablet:openTablet", _ARG_0_)
  print('duscrd')
end)
RegisterCommand(cfg.openCMD .. "_close", function(_ARG_0_, _ARG_1_, _ARG_2_)
  TriggerEvent("omik_polititablet:display", false)
end)
RegisterNetEvent("omik_polititablet:display")
AddEventHandler("omik_polititablet:display", function(_ARG_0_, _ARG_1_)
  print('Nigger')
  --if not DoesEntityExist((PlayerPedId())) then
  --else
  --  _ARG_0_ = _ARG_0_
  --  if not IsEntityDead((PlayerPedId())) then
  --    if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_seat_wall_tablet@female@base", "base", math.floor(3)) then
  --    else
  --      DestroyAllProps()
  --      ClearPedSecondaryTask((PlayerPedId()))
  --      --break
  --    end
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
  print('test')
  SendNUIMessage({
    type = "app/setVerified",
    data = true
  })
 
  Wait(100)
  SetNuiFocus(_ARG_0_, _ARG_0_)
end)
RegisterNetEvent("omik_polititablet:sendNotify")
AddEventHandler("omik_polititablet:sendNotify", function(_ARG_0_)
  if _ARG_0_ == "qbcore" then
    exports["qb-core"]:GetCoreObject().Functions.Notify(cfg.notify)
  end
end)
AddEventHandler("onResourceStop", function(_ARG_0_)
  DestroyAllProps()
  ClearPedSecondaryTask((PlayerPedId()))
  SendNUIMessage({
    type = "app/setHidden",
    data = true
  })
  SetNuiFocus(false, false)
end)
RegisterNUICallback("setGPS", function(_ARG_0_, _ARG_1_)
SetNewWaypoint(json.decode(_ARG_0_.coords).x + 0,0001, json.decode(_ARG_0_.coords).y + 0,0001)
  _ARG_1_(true)
end)
RegisterNUICallback("getVehicleDetails", function(_ARG_0_, _ARG_1_)
  _ARG_1_({
    name = GetLabelText(GetDisplayNameFromVehicleModel(tonumber(_ARG_0_.hash))),
    category = _UPVALUE0_[GetVehicleClassFromName(tonumber(_ARG_0_.hash))]
  })
end)
RegisterNUICallback("close", function(_ARG_0_, _ARG_1_)
  TriggerEvent("omik_polititablet:display", false)
  _ARG_1_(true)
end)
RegisterNUICallback("get_api_info", function(_ARG_0_, _ARG_1_)
  SendNUIMessage({
    type = "api_info/setApiInfo",
    data = {
      framework = cfg.framework
    }
  })
  _ARG_1_(true)
end)
RegisterNUICallback("newKboksEvent", function(_ARG_0_, _ARG_1_)
  TriggerServerEvent("omik_polititablet:newKboksEvent", _ARG_0_)
  _ARG_1_(true)
end)
RegisterNUICallback("newCharge", function(_ARG_0_, _ARG_1_)
  TriggerServerEvent("omik_polititablet:newCharge", _ARG_0_)
  _ARG_1_(true)
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
  if HasModelLoaded(_ARG_0_) then
  else
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
