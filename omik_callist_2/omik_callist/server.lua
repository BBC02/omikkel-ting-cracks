
vRP = module("vrp", "lib/Proxy").getInterface("vRP")
vRPclient = module("vrp", "lib/Tunnel").getInterface("vRP", "vRP")

--AddEventHandler("onResourceStart", function(_ARG_0_)
--  if _ARG_0_ == GetCurrentResourceName() then
--    if Config.framework == "vrp" then
--      vRP = module("vrp", "lib/Proxy").getInterface("vRP")
--      vRPclient = module("vrp", "lib/Tunnel").getInterface("vRP", "vRP")
--    elseif Config.framework == "esx" then
--      if ESX ~= nil then  
--      else
--
--        TriggerEvent(Config.esx_event, function(_ARG_0_)
--          ESX = _ARG_0_
--        end)
--        if ESX ~= nil then
--        else
--          _ARG_0_ = _ARG_0_
--          _ARG_0_ = _ARG_0_
--          print(Config.esx_event, function(_ARG_0_)
--            ESX = _ARG_0_
--          end)
--        end
--      end
--    elseif Config.framework == "qbcore" then
--      QBCore = exports["qb-core"]:GetCoreObject()
--    end
--  end
--end)


function addCallESX(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ ~= nil and _ARG_0_ ~= 0 then
    MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier", {
      identifier = ESX.GetPlayerFromId(_ARG_0_).getIdentifier()
    }, function(_ARG_0_, _ARG_1_)
      if not (#_ARG_0_ >= 0) then
      else
        _ARG_0_ = _ARG_0_
        sCallback:TriggerClientCallback(_UPVALUE0_, nil, {}, function(_ARG_0_)
          table.insert(_UPVALUE0_, {
            id = _UPVALUE1_,
            from_identifier = _UPVALUE2_.getIdentifier(),
            message = _UPVALUE3_,
            sender = Config.prefix .. " " .. _UPVALUE4_[1].phone_number,
            receiver = _UPVALUE5_,
            coords = json.encode({
              x = _ARG_0_.x,
              y = _ARG_0_.y
            }),
            status = json.encode({taken = false, by = ""}),
            date = os.date()
          })
          _UPVALUE1_ = _UPVALUE1_ + 1
          for _FORV_4_ = 1, #_UPVALUE6_ do
            if ESX.GetPlayerFromId(_UPVALUE6_[_FORV_4_]).getJob().name == _UPVALUE5_ then
              TriggerClientEvent("omik_callist:playSound", _UPVALUE6_[_FORV_4_])
              Config.newcall(_UPVALUE6_[_FORV_4_], _UPVALUE3_, _UPVALUE5_, _ARG_0_)
            end
          end
        end)
      end
    end)
  else
    table.insert(_UPVALUE0_, {
      id = _UPVALUE1_,
      from_identifier = 0,
      message = _ARG_1_,
      sender = Config.anonymousCaller,
      receiver = _ARG_2_,
      coords = json.encode({
        x = _ARG_3_.x,
        y = _ARG_3_.y
      }),
      status = json.encode({taken = false, by = ""}),
      date = os.date()
    })
    _UPVALUE1_ = _UPVALUE1_ + 1
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
    for _FORV_8_ = _UPVALUE1_ + 1, #ESX.GetPlayers(), {
      id = _UPVALUE1_,
      from_identifier = 0,
      message = _ARG_1_,
      sender = Config.anonymousCaller,
      receiver = _ARG_2_,
      coords = json.encode({
        x = _ARG_3_.x,
        y = _ARG_3_.y
      }),
      status = json.encode({taken = false, by = ""}),
      date = os.date()
    } do
      if ESX.GetPlayerFromId(ESX.GetPlayers()[_FORV_8_]).getJob().name == _ARG_2_ then
        TriggerClientEvent("omik_callist:playSound", ESX.GetPlayers()[_FORV_8_])
        _ARG_0_ = _ARG_0_
        _ARG_0_ = _ARG_0_
        Config.newcall(ESX.GetPlayers()[_FORV_8_], _ARG_1_, nil, nil)
      end
    end
  end
end
function addCallVRP(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ ~= nil and _ARG_0_ ~= 0 then
    _ARG_0_ = _ARG_0_
    vRP.getUserIdentity({
      vRP.getUserId({nil}),
      function(_ARG_0_)
        sCallback:TriggerClientCallback(_UPVALUE0_, "GetCoords", {}, function(_ARG_0_)
          table.insert(_UPVALUE0_, {
            id = _UPVALUE1_,
            from_identifier = _UPVALUE2_,
            message = _UPVALUE3_,
            sender = Config.prefix .. " " .. _UPVALUE4_.phone,
            receiver = _UPVALUE5_,
            coords = json.encode({
              x = _ARG_0_.x,
              y = _ARG_0_.y
            }),
            status = json.encode({taken = false, by = ""}),
            date = os.date()
          })
          _UPVALUE1_ = _UPVALUE1_ + 1
          for _FORV_4_, _FORV_5_ in pairs(_UPVALUE6_) do
            if not vRP.hasGroup({_FORV_4_, _UPVALUE5_}) then
            else
              TriggerClientEvent("omik_callist:playSound", _FORV_5_)
              _ARG_0_ = _ARG_0_
              Config.newcall(_FORV_5_, _UPVALUE3_, _UPVALUE5_, nil)
            end
          end
        end)
      end
    })
  else
    table.insert(_UPVALUE0_, {
      id = _UPVALUE1_,
      from_identifier = 0,
      message = _ARG_1_,
      sender = Config.anonymousCaller,
      receiver = _ARG_2_,
      coords = json.encode({
        x = _ARG_3_.x,
        y = _ARG_3_.y
      }),
      status = json.encode({taken = false, by = ""}),
      date = os.date()
    })
    _UPVALUE1_ = _UPVALUE1_ + 1
    _ARG_0_ = _ARG_0_
    for _FORV_8_, _FORV_9_ in pairs(_UPVALUE0_) do
      if not vRP.hasGroup({_FORV_8_, _ARG_2_}) then
      else
        TriggerClientEvent("omik_callist:playSound", _FORV_9_)
        _ARG_0_ = _ARG_0_
        _ARG_0_ = _ARG_0_
        Config.newcall(_FORV_9_, _ARG_1_, _ARG_2_, nil)
      end
    end
  end
end
function addCallQBCore(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ ~= nil and _ARG_0_ ~= 0 then
    sCallback:TriggerClientCallback(_ARG_0_, "GetCoords", {}, function(_ARG_0_)
      table.insert(_UPVALUE0_, {
        id = _UPVALUE1_,
        from_identifier = _UPVALUE2_.PlayerData.citizenid,
        message = _UPVALUE3_,
        sender = Config.prefix .. " " .. _UPVALUE2_.PlayerData.charinfo.phone,
        receiver = _UPVALUE4_,
        coords = json.encode({
          x = _ARG_0_.x,
          y = _ARG_0_.y
        }),
        status = json.encode({taken = false, by = ""}),
        date = os.date()
      })
      _UPVALUE1_ = _UPVALUE1_ + 1
      for _FORV_4_, _FORV_5_ in pairs(_UPVALUE5_) do
        _ARG_0_ = _ARG_0_
        do return end
        do return end
        if _FORV_5_.PlayerData.job.onduty then
          TriggerClientEvent("omik_callist:playSound", _FORV_4_)
          _ARG_0_ = _ARG_0_
          Config.newcall(_FORV_4_, _UPVALUE3_, _UPVALUE4_, nil)
        end
      end
    end)
  else
    table.insert(_UPVALUE0_, {
      id = _UPVALUE1_,
      from_identifier = 0,
      message = _ARG_1_,
      sender = Config.anonymousCaller,
      receiver = _ARG_2_,
      coords = json.encode({
        x = _ARG_3_.x,
        y = _ARG_3_.y
      }),
      status = json.encode({taken = false, by = ""}),
      date = os.date()
    })
    _UPVALUE1_ = _UPVALUE1_ + 1
    _ARG_0_ = _ARG_0_
    for _FORV_8_, _FORV_9_ in pairs(_UPVALUE0_) do
      _ARG_0_ = _ARG_0_
      do return end
      do return end
      if _FORV_9_.PlayerData.job.onduty then
        TriggerClientEvent("omik_callist:playSound", _FORV_8_)
        _ARG_0_ = _ARG_0_
        _ARG_0_ = _ARG_0_
        Config.newcall(_FORV_8_, _ARG_1_, nil, nil)
      end
    end
  end
end
function addCallToDatabaseESX(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ == nil then
  elseif _ARG_0_ == 0 then
  else
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
      identifier = ESX.GetPlayerFromId(_ARG_0_).getIdentifier()
    }, function(_ARG_0_, _ARG_1_)
      if not (#_ARG_0_ >= 0) then
      else
        _ARG_0_ = _ARG_0_
        sCallback:TriggerClientCallback(_UPVALUE0_, nil, {}, function(_ARG_0_)
          MySQL.Async.execute("INSERT INTO omik_callist(id, from_identifier, message, sender, receiver, coords, status, date) VALUES(NULL, @from_identifier, @message, @sender, @receiver, @coords, @status, NULL)", {
            from_identifier = _UPVALUE0_.getIdentifier(),
            message = _UPVALUE1_,
            sender = Config.prefix .. " " .. _UPVALUE2_[1].phone_number,
            receiver = _UPVALUE3_,
            coords = json.encode({
              x = _ARG_0_.x,
              y = _ARG_0_.y
            }),
            status = json.encode({taken = false, by = ""})
          })
          for _FORV_4_ = 1, #_UPVALUE4_ do
            ESX.GetPlayerFromId(_UPVALUE4_[_FORV_4_]).getJob().name(_UPVALUE3_)
            do return end
            do return end
            TriggerClientEvent("omik_callist:playSound", _UPVALUE4_[_FORV_4_])
            Config.newcall(_UPVALUE4_[_FORV_4_], _UPVALUE1_, _UPVALUE3_, _ARG_0_)
          end
        end)
      end
    end)
    --break
  end
  MySQL.Async.execute("INSERT INTO omik_callist(id, from_identifier, message, sender, receiver, coords, status, date) VALUES(NULL, @from_identifier, @message, @sender, @receiver, @coords, @status, NULL)", {
    from_identifier = 0,
    message = _ARG_1_,
    sender = Config.anonymousCaller,
    receiver = _ARG_2_,
    coords = json.encode({
      x = _ARG_3_.x,
      y = _ARG_3_.y
    }),
    status = json.encode({taken = false, by = ""})
  })
  for _FORV_8_ = 1, #ESX.GetPlayers() do
    if ESX.GetPlayerFromId(ESX.GetPlayers()[_FORV_8_]).getJob().name ~= _ARG_2_ then
    else
      TriggerClientEvent("omik_callist:playSound", ESX.GetPlayers()[_FORV_8_])
      _ARG_0_ = _ARG_0_
      _ARG_0_ = _ARG_0_
      Config.newcall(ESX.GetPlayers()[_FORV_8_], _ARG_1_, nil, nil)
    end
  end
end
function addCallToDatabaseVRP(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ == nil or _ARG_0_ == 0 then
  else
    _ARG_0_ = _ARG_0_
    vRP.getUserIdentity({
      vRP.getUserId({nil}),
      function(_ARG_0_)
        sCallback:TriggerClientCallback(_UPVALUE0_, "GetCoords", {}, function(_ARG_0_)
          MySQL.Async.execute("INSERT INTO omik_callist(id, from_identifier, message, sender, receiver, coords, status, date) VALUES(NULL, @from_identifier, @message, @sender, @receiver, @coords, @status, NULL)", {
            from_identifier = _UPVALUE0_,
            message = _UPVALUE1_,
            sender = Config.prefix .. " " .. _UPVALUE2_.phone,
            receiver = _UPVALUE3_,
            coords = json.encode({
              x = _ARG_0_.x,
              y = _ARG_0_.y
            }),
            status = json.encode({taken = false, by = ""})
          })
          for _FORV_4_, _FORV_5_ in pairs(_UPVALUE4_) do
            if vRP.hasGroup({_FORV_4_, _UPVALUE3_}) then
              TriggerClientEvent("omik_callist:playSound", _FORV_5_)
              _ARG_0_ = _ARG_0_
              Config.newcall(_FORV_5_, _UPVALUE1_, _UPVALUE3_, nil)
            end
          end
        end)
      end
    })
    --break
  end
  MySQL.Async.execute("INSERT INTO omik_callist(id, from_identifier, message, sender, receiver, coords, status, date) VALUES(NULL, @from_identifier, @message, @sender, @receiver, @coords, @status, NULL)", {
    from_identifier = 0,
    message = _ARG_1_,
    sender = Config.anonymousCaller,
    receiver = _ARG_2_,
    coords = json.encode({
      x = _ARG_3_.x,
      y = _ARG_3_.y
    }),
    status = json.encode({taken = false, by = ""})
  })
  for _FORV_8_, _FORV_9_ in pairs((vRP.getUsers())) do
    if not vRP.hasGroup({_FORV_8_, _ARG_2_}) then
    else
      TriggerClientEvent("omik_callist:playSound", _FORV_9_)
      _ARG_0_ = _ARG_0_
      _ARG_0_ = _ARG_0_
      Config.newcall(_FORV_9_, _ARG_1_, _ARG_2_, nil)
    end
  end
end
function addCallToDatabaseQBCore(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ ~= nil and _ARG_0_ ~= 0 then
    sCallback:TriggerClientCallback(_ARG_0_, "GetCoords", {}, function(_ARG_0_)
      MySQL.Async.execute("INSERT INTO omik_callist(id, from_identifier, message, sender, receiver, coords, status, date) VALUES(NULL, @from_identifier, @message, @sender, @receiver, @coords, @status, NULL)", {
        from_identifier = _UPVALUE0_.PlayerData.citizenid,
        message = _UPVALUE1_,
        sender = Config.prefix .. " " .. _UPVALUE0_.PlayerData.charinfo.phone,
        receiver = _UPVALUE2_,
        coords = json.encode({
          x = _ARG_0_.x,
          y = _ARG_0_.y
        }),
        status = json.encode({taken = false, by = ""})
      })
      for _FORV_4_, _FORV_5_ in pairs(_UPVALUE3_) do
        if _FORV_5_.PlayerData.job.name ~= _UPVALUE2_ or not _FORV_5_.PlayerData.job.onduty then
        else
          TriggerClientEvent("omik_callist:playSound", _FORV_4_)
          _ARG_0_ = _ARG_0_
          Config.newcall(_FORV_4_, _UPVALUE1_, _UPVALUE2_, nil)
        end
      end
    end)
  else
    MySQL.Async.execute("INSERT INTO omik_callist(id, from_identifier, message, sender, receiver, coords, status, date) VALUES(NULL, @from_identifier, @message, @sender, @receiver, @coords, @status, NULL)", {
      from_identifier = 0,
      message = _ARG_1_,
      sender = Config.anonymousCaller,
      receiver = _ARG_2_,
      coords = json.encode({
        x = _ARG_3_.x,
        y = _ARG_3_.y
      }),
      status = json.encode({taken = false, by = ""})
    })
    for _FORV_8_, _FORV_9_ in pairs((QBCore.Functions.GetQBPlayers())) do
      _ARG_0_ = _ARG_0_
      do return end
      do return end
      if _FORV_9_.PlayerData.job.onduty then
        TriggerClientEvent("omik_callist:playSound", _FORV_8_)
        _ARG_0_ = _ARG_0_
        _ARG_0_ = _ARG_0_
        Config.newcall(_FORV_8_, _ARG_1_, nil, nil)
      end
    end
  end
end
RegisterServerEvent("omik_callist:sendNotification")
AddEventHandler("omik_callist:sendNotification", function(_ARG_0_, _ARG_1_)
  if Config.framework ~= "qbcore" then
  elseif _ARG_0_ == "gps" then
    Config.setgpstext(QBCore.Functions.GetPlayerByCitizenId(_ARG_1_).PlayerData.source)
  elseif _ARG_0_ == "accept" then
    Config.taketext(QBCore.Functions.GetPlayerByCitizenId(_ARG_1_).PlayerData.source)
    do return end
    if Config.framework == "esx" then
      _ARG_0_ = _ARG_0_
      if _ARG_0_ == "gps" then
        Config.setgpstext(ESX.GetPlayerFromIdentifier(Config.taketext).source)
      elseif _ARG_0_ == "accept" then
        Config.taketext(ESX.GetPlayerFromIdentifier(Config.taketext).source)
      end
    elseif Config.framework == "vrp" and vRP.getUserSource({
      tonumber(_ARG_1_)
    }) ~= nil then
      if _ARG_0_ == "gps" then
        _ARG_0_ = _ARG_0_
        Config.setgpstext(tonumber(_ARG_1_))
      elseif _ARG_0_ ~= "accept" then
      else
        _ARG_0_ = _ARG_0_
        Config.taketext(tonumber(_ARG_1_))
      end
    end
  end
end)
RegisterServerEvent("omik_callist:gcphone:contact")
AddEventHandler("omik_callist:gcphone:contact", function(_ARG_0_, _ARG_1_)
  if Config.framework ~= "esx" then
  else
    MySQL.Async.fetchAll("SELECT * FROM users WHERE phone_number = @phone_number", {phone_number = _ARG_1_}, function(_ARG_0_, _ARG_1_)
      if #_ARG_0_ > 0 then
        _ARG_0_ = _ARG_0_
        TriggerEvent("gcPhone:_internalAddMessage", _UPVALUE0_.getJob().name, _UPVALUE1_, _UPVALUE2_, nil, function(_ARG_0_)
          TriggerClientEvent("gcPhone:receiveMessage", _UPVALUE0_.source, _ARG_0_)
        end)
      end
    end)
    --break
  end
  if Config.framework ~= "vrp" then
  else
    _ARG_0_ = _ARG_0_
    MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE phone = @phone", {phone = _ARG_1_}, function(_ARG_0_, _ARG_1_)
      if #_ARG_0_ > 0 then
        TriggerEvent("gcPhone:_internalAddMessage", _UPVALUE0_, _UPVALUE1_, _UPVALUE2_, 0, function(_ARG_0_)
          TriggerClientEvent("gcPhone:receiveMessage", _UPVALUE0_, _ARG_0_)
        end)
      end
    end)
  end
end)
AddEventHandler("playerDropped", function(_ARG_0_)
  if Config.deleteCallsOnDisconnect then
    if Config.framework == "esx" then
    elseif Config.framework == "vrp" then
      _ARG_0_ = _ARG_0_
      _ARG_0_ = _ARG_0_
    elseif Config.framework ~= "qbcore" then
    else
    end
    if Config.databaseless then
      for _FORV_6_, _FORV_7_ in pairs(_UPVALUE0_) do
        _ARG_0_ = _ARG_0_
        do return end
        do return end
        _UPVALUE0_[_FORV_6_] = nil
      end
    else
      MySQL.Async.execute("DELETE FROM omik_callist WHERE from_identifier = @from_identifier", {
        from_identifier = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
      })
    end
  end
end)
sCallback:RegisterServerCallback("api:getCalls", function(_ARG_0_)
  if Config.framework == "vrp" then
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
  elseif Config.framework ~= "qbcore" then
  else
    --break
  end
  if Config.framework ~= "esx" then
  else
  end
  if not Config.databaseless then
  else
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
    for _FORV_7_ = #_UPVALUE0_, ESX.GetPlayerFromId(_ARG_0_).getJob(), {
      vRP.getUserId({_ARG_0_}),
      Config.GroupType
    } do
      if _UPVALUE0_[_FORV_7_].receiver == ESX.GetPlayerFromId(_ARG_0_).getJob().name then
        table.insert({}, _UPVALUE0_[_FORV_7_])
      end
    end
    --break
  end
  if #MySQL.Sync.fetchAll("SELECT id, from_identifier, message, sender, receiver, coords, status, date FROM omik_callist WHERE receiver = @job ORDER BY id DESC LIMIT 0,30", {
    job = ESX.GetPlayerFromId(_ARG_0_).getJob().name
  }) > 0 then
    return {
      data = MySQL.Sync.fetchAll("SELECT id, from_identifier, message, sender, receiver, coords, status, date FROM omik_callist WHERE receiver = @job ORDER BY id DESC LIMIT 0,30", {
        job = ESX.GetPlayerFromId(_ARG_0_).getJob().name
      }),
      status = "Success"
    }
  else
    return {
      data = {},
      status = "Ingen opkald"
    }
  end
end)
sCallback:RegisterServerCallback("api:delete", function(_ARG_0_, _ARG_1_)
  if Config.databaseless then
    for _FORV_6_, _FORV_7_ in pairs(_UPVALUE0_) do
      if _FORV_7_.id == _ARG_1_ then
        _UPVALUE0_[_FORV_6_] = nil
      end
    end
  else
  end
  if MySQL.Sync.execute("DELETE FROM omik_callist WHERE id = @id", {id = _ARG_1_}) then
    _ARG_0_ = _ARG_0_
    return (MySQL.Sync.execute("DELETE FROM omik_callist WHERE id = @id", {id = _ARG_1_}))
  else
    _ARG_0_ = _ARG_0_
    return (MySQL.Sync.execute("DELETE FROM omik_callist WHERE id = @id", {id = _ARG_1_}))
  end
end)
sCallback:RegisterServerCallback("api:deleteAllCalls", function(_ARG_0_, _ARG_1_)
  _ARG_0_ = _ARG_0_
  if Config.framework ~= "vrp" then
  else
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
    --break
  end
  if Config.framework == "qbcore" then
  elseif Config.framework ~= "esx" then
  else
  end
  if not Config.databaseless then
  else
    for _FORV_7_, _FORV_8_ in pairs(_UPVALUE0_) do
      _ARG_0_ = _ARG_0_
      do return end
      do return end
      _UPVALUE0_[_FORV_7_] = nil
    end
    --break
  end
  if not MySQL.Sync.execute("DELETE FROM omik_callist WHERE receiver = @job", {
    job = ESX.GetPlayerFromId(_ARG_0_).getJob().name
  }) then
  else
    _ARG_0_ = _ARG_0_
    do return (MySQL.Sync.execute("DELETE FROM omik_callist WHERE receiver = @job", {
      job = ESX.GetPlayerFromId(_ARG_0_).getJob().name
    })) end
    --break
  end
  _ARG_0_ = _ARG_0_
  return (MySQL.Sync.execute("DELETE FROM omik_callist WHERE receiver = @job", {
    job = ESX.GetPlayerFromId(_ARG_0_).getJob().name
  }))
end)
sCallback:RegisterServerCallback("api:accept", function(_ARG_0_, _ARG_1_)
  if Config.framework ~= "esx" then
  else
    --break
  end
  if Config.framework ~= "qbcore" then
  else
    _ARG_0_ = _ARG_0_
    --break
  end
  if Config.framework ~= "vrp" then
  else
    _ARG_0_ = _ARG_0_
    _ARG_0_ = _ARG_0_
    vRP.getUserIdentity({
      QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.lastname,
      function(_ARG_0_)
        _UPVALUE0_ = _ARG_0_.firstname .. " " .. _ARG_0_.name
        if not Config.databaseless then
        else
          for _FORV_4_, _FORV_5_ in pairs(_UPVALUE1_) do
            if _FORV_5_.id == _UPVALUE2_ then
              _UPVALUE1_[_FORV_4_].status = json.encode({taken = true, by = _UPVALUE0_})
              _UPVALUE3_ = true
            else
              do return end
              _UPVALUE3_ = MySQL.Sync.execute("UPDATE omik_callist SET status = @status WHERE id = @id", {
                status = json.encode({taken = true, by = _UPVALUE0_}),
                id = _UPVALUE2_
              })
            end
          end
        end
      end
    })
  end
  if Config.framework == "qbcore" or Config.framework == "esx" then
    if not Config.databaseless then
    else
      for _FORV_7_, _FORV_8_ in pairs(_UPVALUE0_) do
        _ARG_0_ = _ARG_0_
        do return end
        do return end
        _UPVALUE0_[_FORV_7_].status = json.encode({
          taken = true,
          by = QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.firstname .. nil .. QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.lastname
        })
        --break
      end
      --break
    end
  end
  if MySQL.Sync.execute("UPDATE omik_callist SET status = @status WHERE id = @id", {
    status = json.encode({
      taken = true,
      by = QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.firstname .. nil .. QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.lastname
    }),
    id = _ARG_1_
  }) then
    _ARG_0_ = _ARG_0_
    return (MySQL.Sync.execute("UPDATE omik_callist SET status = @status WHERE id = @id", {
      status = json.encode({
        taken = true,
        by = QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.firstname .. nil .. QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.lastname
      }),
      id = _ARG_1_
    }))
  else
    _ARG_0_ = _ARG_0_
    return (MySQL.Sync.execute("UPDATE omik_callist SET status = @status WHERE id = @id", {
      status = json.encode({
        taken = true,
        by = QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.firstname .. nil .. QBCore.Functions.GetPlayer(_ARG_0_).PlayerData.charinfo.lastname
      }),
      id = _ARG_1_
    }))
  end
end)

