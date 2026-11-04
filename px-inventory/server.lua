local config = PxInventory
local avatars, requests = {}, {}
local discordBackoff = 0
local warnings = {}
local function warn(key, message)
    if (warnings[key] or 0) > os.time() then return end
    warnings[key] = os.time() + 60
    print('[px-inventory] ' .. message)
end

local function avatarFor(source)
    if not config.Discord.Enabled then return nil end
    local identifier = GetPlayerIdentifierByType(source, 'discord')
    local id = identifier and identifier:match('^discord:(%d+)$')
    local token = GetConvar('inventory:discordBotToken', '')
    if not id then warn('id:' .. source, 'Player ' .. source .. ' has no FiveM Discord identifier. Reconnect with Discord running.'); return nil end
    token = token:match('^%s*(.-)%s*$'):gsub('^Bot%s+', '')
    if token == '' then warn('token', 'inventory:discordBotToken is empty.'); return nil end
    local guild = GetConvar('inventory:discordGuildId', ''):match('^%s*(.-)%s*$')
    if guild ~= '' and not guild:match('^%d+$') then warn('guild', 'inventory:discordGuildId must contain only digits.'); return nil end
    local now = os.time()
    local key = guild .. ':' .. id
    local cached = avatars[key]
    if (not cached or cached.expires <= now) and now >= discordBackoff then
        cached = { url = cached and cached.url, expires = now + math.max(15, config.Discord.RetrySeconds) }
        avatars[key] = cached
        local endpoint = guild ~= '' and ('guilds/' .. guild .. '/members/' .. id) or ('users/' .. id)
        PerformHttpRequest('https://discord.com/api/v10/' .. endpoint, function(status, body)
            if status == 429 then discordBackoff = os.time() + math.max(60, config.Discord.RetrySeconds) end
            if status ~= 200 then
                local reasons = { [401] = 'Invalid bot token.', [403] = 'Bot cannot access this Discord server.', [404] = 'Discord server or member not found. Check Guild ID and membership.', [429] = 'Discord rate limit; retry delayed.' }
                warn('http:' .. status, 'Discord HTTP ' .. status .. ': ' .. (reasons[status] or 'Avatar request failed.'))
                return
            end
            local ok, response = pcall(json.decode, body)
            if not ok or type(response) ~= 'table' then return end
            local user = guild ~= '' and response.user or response
            if type(user) ~= 'table' then return end
            local memberAvatar = guild ~= '' and response.avatar
            local hash = type(memberAvatar) == 'string' and memberAvatar or user.avatar
            if type(hash) == 'string' and hash:match('^[%w_]+$') then
                local size = config.Discord.AvatarSize
                if size ~= 64 and size ~= 128 and size ~= 256 and size ~= 512 then size = 128 end
                local path = type(memberAvatar) == 'string' and ('guilds/' .. guild .. '/users/' .. id .. '/avatars/') or ('avatars/' .. id .. '/')
                cached.url = ('https://cdn.discordapp.com/%s%s.png?size=%d'):format(path, hash, size)
            else
                cached.url = nil
            end
            cached.expires = os.time() + math.max(60, config.Discord.CacheSeconds)
            if GetPlayerIdentifierByType(source, 'discord') == identifier then
                requests[source] = nil
                TriggerClientEvent('ox_inventory:redesignAvatar', source, cached.url or false)
                print(('[px-inventory] Player %s avatar: %s; sent to inventory UI'):format(source, cached.url and 'READY' or 'NO_AVATAR'))
            end
        end, 'GET', '', { Authorization = 'Bot ' .. token })
    end
    return cached and cached.url
end

local function readProfile(source)
    local framework = config.Framework
    if framework == 'auto' then framework = GetConvar('inventory:framework', 'esx') end
    if framework == 'esx' and GetResourceState('es_extended') == 'started' then
        local player = exports.es_extended:getSharedObject().GetPlayerFromId(source)
        if not player then return {} end
        local bank = player.getAccount(config.Accounts.Bank)
        local cash = config.Accounts.ESXCash == 'money' and player.getMoney() or nil
        if cash == nil then local account = player.getAccount(config.Accounts.ESXCash); cash = account and account.money end
        return { name = player.getName(), cash = cash, bank = bank and bank.money }
    end
    local player
    if (framework == 'qbx' or framework == 'qbox') and GetResourceState('qbx_core') == 'started' then
        player = exports.qbx_core:GetPlayer(source)
    elseif (framework == 'qb' or framework == 'qbcore') and GetResourceState('qb-core') == 'started' then
        player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(source)
    end
    if not player then return {} end
    local data = player.PlayerData
    local info = data.charinfo or {}
    return { name = ((info.firstname or '') .. ' ' .. (info.lastname or '')):match('^%s*(.-)%s*$'), cash = data.money and data.money[config.Accounts.QBCash], bank = data.money and data.money[config.Accounts.Bank] }
end

lib.callback.register('ox_inventory:redesignProfile', function(source)
    local now = os.time()
    local previous = requests[source]
    if previous and now - previous.time < math.max(1, config.RequestCooldown) then return previous.data end
    local ok, data = pcall(readProfile, source)
    if not ok then data = {} end
    data.avatar = avatarFor(source)
    requests[source] = { time = now, data = data }
    return data
end)

AddEventHandler('playerDropped', function() requests[source] = nil end)

RegisterCommand('px_inventory_discord', function(source)
    if source ~= 0 then return end
    local token = GetConvar('inventory:discordBotToken', '')
    local guild = GetConvar('inventory:discordGuildId', '')
    print(('[px-inventory] Runtime token: %s; Guild ID: %s'):format(token ~= '' and 'SET' or 'EMPTY', guild ~= '' and guild or 'EMPTY'))
    for _, player in ipairs(GetPlayers()) do
        local id = GetPlayerIdentifierByType(player, 'discord')
        print(('[px-inventory] Player %s; Discord identifier: %s'):format(player, id and 'PRESENT' or 'MISSING'))
        if id then
            avatars[guild .. ':' .. id:gsub('^discord:', '')] = nil
            requests[tonumber(player)] = nil
            local url = avatarFor(tonumber(player))
            print('[px-inventory] Avatar lookup started for player ' .. player)
            SetTimeout(5000, function()
                local cached = avatars[guild .. ':' .. id:gsub('^discord:', '')]
                print(('[px-inventory] Player %s avatar: %s'):format(player, cached and cached.url and 'READY' or 'UNAVAILABLE (check Discord HTTP messages)'))
            end)
        end
    end
end, true)
