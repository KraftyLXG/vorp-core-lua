AddEventHandler('vorp:getCharacter', function(player, cb)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        cb(_users[sid].GetUsedCharacter().getCharacter())
    end
end)

AddEventHandler('vorp:addMoney', function(player, typeCash, quantity)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        _users[sid].GetUsedCharacter().addCurrency(typeCash, quantity)
        _users[sid].GetUsedCharacter().updateCharUi()
    end
end)

AddEventHandler('vorp:removeMoney', function(player, typeCash, quantity)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        _users[sid].GetUsedCharacter().removeCurrency(typeCash, quantity)
        _users[sid].GetUsedCharacter().updateCharUi()
    end
end)

AddEventHandler('vorp:addXp', function(player, quantity)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        _users[sid].GetUsedCharacter().addXp(quantity)
        _users[sid].GetUsedCharacter().updateCharUi()
    end
end)

AddEventHandler('vorp:removeXp', function(player, quantity)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        _users[sid].GetUsedCharacter().removeXp(quantity)
        _users[sid].GetUsedCharacter().updateCharUi()
    end
end)

AddEventHandler('vorp:setJob', function(player, job, jobgrade)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        _users[sid].GetUsedCharacter().setJob(job)
        _users[sid].GetUsedCharacter().setJobGrade(jobgrade)
    end
end)

AddEventHandler('vorp:setGroup', function(player, group)
    local sid = GetSteamID(player)

    if _users[sid] ~= nil then
        _users[sid].GetUsedCharacter().setGroup(group)
    end
end)

AddEventHandler('vorp:whitelistPlayer', function(id)
    AddUserToWhitelistById(id)
end)

AddEventHandler('vorp:unwhitelistPlayer', function(id)
    RemoveUserFromWhitelistById(id)
end)

AddEventHandler('getCore', function(cb)
    local coreData = {}

    coreData.getUser = function(source)
        if source == nil then return nil end

        local sid = GetSteamID(source)

        if _users[sid] then
            return _users[sid].GetUser()
        else
            return nil
        end
    end

    coreData.maxCharacters = Config["MaxCharacters"]

    coreData.addRpcCallback = function(name, callback)
        print('Callback registered -> ' .. name)
        --ServerCallBacks[name] = callback
        TriggerEvent("vorp:addNewCallBack", name, callback)
    end
        
    coreData.getUsers = function()
        return _users
    end

    coreData.Warning = function(text)
        print("^3WARNING: ^7" .. tostring(text) .. "^7")
    end

    coreData.Error = function(text)
        print("^1ERROR: ^7" .. tostring(text) .. "^7")
        TriggerClientEvent("vorp_core:LogError")
    end

    coreData.Success = function(text)
        print("^2SUCCESS: ^7" .. tostring(text) .. "^7")
    end

    coreData.NotifyTip = function(source, text, duration)
        local _source = source
        TriggerClientEvent('vorp:Tip', _source, text, duration)
    end

    coreData.NotifyLeft = function(source, title, subtitle, dict, icon, duration, colors)
        local _source = source
        TriggerClientEvent('vorp:NotifyLeft', _source, title, subtitle, dict, icon, duration, colors)
    end

    coreData.NotifyRightTip = function(source, text, duration)
        local _source = source
        TriggerClientEvent('vorp:TipRight', _source, text, duration)
    end

    coreData.NotifyObjective = function(source, text, duration)
        local _source = source
        TriggerClientEvent('vorp:TipBottom', _source, text, duration)
    end

    coreData.NotifyTop = function(source, text, location, duration)
        local _source = source
        TriggerClientEvent('vorp:NotifyTop', _source, text, location, duration)
    end

    coreData.NotifySimpleTop = function(source, text, subtitle, duration)
        local _source = source
        TriggerClientEvent('vorp:ShowTopNotification', _source, text, subtitle, duration)
    end

    coreData.NotifyAvanced = function(source, text, dict, icon, text_color, duration)
        local _source = source
        TriggerClientEvent('vorp:ShowAdvancedRightNotification', _source, text, dict, icon, text_color, duration)
    end

    coreData.NotifyCenter = function(source, text, duration,color)
        local _source = source
        TriggerClientEvent('vorp:ShowSimpleCenterText', _source, text, duration,color)
    end

    coreData.NotifyBottomRight = function(source, text, duration)
        local _source = source
        TriggerClientEvent('vorp:ShowBottomRight', _source, text, duration)
    end

    coreData.NotifyFail = function(source, text, subtitle, duration)
        local _source = source
        TriggerClientEvent('vorp:failmissioNotifY', _source, text, subtitle, duration)
    end

    coreData.NotifyDead = function(source, title, audioRef, audioName, duration)
        local _source = source
        TriggerClientEvent('vorp:deadplayerNotifY', _source, title, audioRef, audioName, duration)
    end

    coreData.NotifyUpdate = function(source, title, subtitle, duration)
        local _source = source
        TriggerClientEvent('vorp:updatemissioNotify', title, subtitle, duration)
    end

    coreData.NotifyWarning = function(source, title, msg, audioRef, audioName, duration)
        local _source = source
        TriggerClientEvent('vorp:warningNotify', _source, title, msg, audioRef, audioName, duration)
    end

  

    cb(coreData)
end)

AddEventHandler('getWhitelistTables', function(cb)
    local whitelistData = {}

    whitelistData.getEntry = function(identifier)
        if identifier == nil then return nil end

        local userid = GetUserId(identifier)

        if _whitelist[userid] then
            return _whitelist[userid].GetEntry()
        else
            return nil
        end
    end
    
    whitelistData.getEntries = function()
        return _whitelist
    end

    cb(whitelistData)
end)
