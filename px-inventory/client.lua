local pending = false
local latestProfile = {}
RegisterNetEvent('ox_inventory:redesignAvatar', function(avatar)
    if source ~= 65535 then return end
    latestProfile.avatar = avatar or nil
    SendNUIMessage({ action = 'redesignProfile', data = latestProfile })
end)
RegisterNUICallback('redesignProfile', function(_, cb)
    if pending then cb(latestProfile) return end
    pending = true
    local ok, profile = pcall(lib.callback.await, 'ox_inventory:redesignProfile', false)
    pending = false
    if ok and type(profile) == 'table' then latestProfile = profile end
    cb(latestProfile)
end)

local currentInjuries = {
    head = false,
    torso = false,
    left_arm = false,
    right_arm = false,
    left_leg = false,
    right_leg = false
}

local BONE_PARTS = {
    -- Head i Neck
    [31086] = 'head', 
    [39317] = 'head', 

    -- Torso / Spine / Pelvis
    [24816] = 'torso', 
    [24817] = 'torso', 
    [24818] = 'torso', 
    [24819] = 'torso', 
    [11816] = 'torso', 
    [57597] = 'torso', 

    -- Left Arm 
    [45509] = 'left_arm',
    [61163] = 'left_arm',
    [18905] = 'left_arm',
    [60309] = 'left_arm',
    [26610] = 'left_arm',
    [26611] = 'left_arm',
    [26612] = 'left_arm',
    [26613] = 'left_arm',
    [26614] = 'left_arm',

    -- Right Arm 
    [40269] = 'right_arm',
    [28252] = 'right_arm',
    [57005] = 'right_arm',
    [58866] = 'right_arm',
    [64016] = 'right_arm',
    [64017] = 'right_arm',
    [64096] = 'right_arm',
    [64097] = 'right_arm',
    [64098] = 'right_arm',

    -- Left Leg 
    [58271] = 'left_leg',
    [63931] = 'left_leg',
    [14201] = 'left_leg',
    [2108]  = 'left_leg',

    -- Right Leg
    [51826] = 'right_leg',
    [36864] = 'right_leg',
    [52335] = 'right_leg',
    [20781] = 'right_leg',
}

local function sendInjuries()
    SendNUIMessage({
        action = 'updateInjuries',
        data = currentInjuries,
        injuries = currentInjuries
    })
end

local function clearAllInjuries()
    for k in pairs(currentInjuries) do
        currentInjuries[k] = false
    end
    sendInjuries()
end

local prevHealth = 0
local wasFalling = false
local wasDead = false

CreateThread(function()
    Wait(1000)
    local ped = PlayerPedId()
    prevHealth = GetEntityHealth(ped)
    wasDead = IsEntityDead(ped) or prevHealth <= 100

    while true do
        ped = PlayerPedId()
        local isFalling = IsPedFalling(ped)
        local isRagdoll = IsPedRagdoll(ped)

        local sleep = (isFalling or isRagdoll) and 100 or 400
        Wait(sleep)

        local health = GetEntityHealth(ped)
        local maxHealth = GetEntityMaxHealth(ped)
        local isDead = IsEntityDead(ped) or health <= 100

        if wasDead and not isDead and health > 100 then
            clearAllInjuries()

        elseif not isDead and ((health > prevHealth and prevHealth > 0) or health >= (maxHealth - 2)) then
            clearAllInjuries()

        elseif health < prevHealth and prevHealth > 0 then
            local damage = prevHealth - health
            local hitSuccess, hitBone = GetPedLastDamageBone(ped)

            local isFall = wasFalling or isFalling or HasEntityBeenDamagedByWeapon(ped, `WEAPON_FALL`, 0) or HasEntityBeenDamagedByWeapon(ped, -35569601, 0)
            if isFall then
                currentInjuries.left_leg = true
                currentInjuries.right_leg = true
                if damage > 25 then
                    currentInjuries.torso = true
                end

            elseif hitSuccess and hitBone and hitBone ~= 0 and BONE_PARTS[hitBone] then
                local part = BONE_PARTS[hitBone]
                currentInjuries[part] = true
            else
                currentInjuries.torso = true
                if damage > 35 then
                    currentInjuries.left_leg = true
                    currentInjuries.right_leg = true
                end
            end

            ClearEntityLastDamageEntity(ped)
            ClearPedLastDamageBone(ped)
            sendInjuries()
        end

        prevHealth = health
        wasFalling = isFalling
        wasDead = isDead
    end
end)

AddEventHandler('gameEventTriggered', function(event, args)
    if event ~= 'CEventDamage' then return end
    local victim = args[1]
    if victim ~= PlayerPedId() then return end

    local weaponHash = args[7]
    local success, hitBone = GetPedLastDamageBone(victim)

    if weaponHash == -35569601 or weaponHash == `WEAPON_FALL` or IsPedFalling(victim) then
        currentInjuries.left_leg = true
        currentInjuries.right_leg = true
    elseif success and hitBone and BONE_PARTS[hitBone] then
        local part = BONE_PARTS[hitBone]
        currentInjuries[part] = true
    else
        currentInjuries.torso = true
    end

    ClearPedLastDamageBone(victim)
    sendInjuries()
end)
local healEvents = {
    -- ESX
    'esx:heal',
    'esx:revive',
    'esx_ambulancejob:heal',
    'esx_ambulancejob:revive',
    'esx_basicneeds:healPlayer',
    'esx:onPlayerSpawn',
    'esx:playerLoaded',

    -- QBCore
    'hospital:client:Revive',
    'hospital:client:Heal',
    'hospital:client:TreatWounds',
    'qb-ambulancejob:client:Revive',
    'qb-ambulancejob:client:Heal',
    'QBCore:Client:OnPlayerLoaded',

    -- Qbox
    'qbx_medical:client:playerRevived',
    'qbx_medical:client:playerHealed',
    'qbx_medical:client:healInjuries',
    'qbx_core:client:playerLoaded',

    -- standalone / wasabi / txadmin
    'ambulance:revive',
    'ambulance:heal',
    'wasabi_ambulance:heal',
    'wasabi_ambulance:revive',
    'txAdmin:healed',
    'txAdmin:events:healed',
    'txAdmin:revived',
    'playerSpawned'
}

for i = 1, #healEvents do
    local evt = healEvents[i]
    RegisterNetEvent(evt, clearAllInjuries)
    AddEventHandler(evt, clearAllInjuries)
end

RegisterNetEvent('ox_inventory:openInventory', sendInjuries)
RegisterNetEvent('ox_inventory:forceOpenInventory', sendInjuries)

AddStateBagChangeHandler('invOpen', ('player:%s'):format(GetPlayerServerId(PlayerId())), function(_, _, value)
    if value then
        sendInjuries()
    end
end)

RegisterNUICallback('getInjuries', function(_, cb)
    cb(currentInjuries)
end)

-- test sdsd
RegisterCommand('testinjury', function(_, args)
    local part = args[1] and string.lower(args[1])
    if part == 'clear' then
        for k in pairs(currentInjuries) do currentInjuries[k] = false end
    elseif part == 'all' then
        for k in pairs(currentInjuries) do currentInjuries[k] = true end
    elseif part and currentInjuries[part] ~= nil then
        currentInjuries[part] = not currentInjuries[part]
    else
        currentInjuries.head = true
        currentInjuries.torso = true
    end
    sendInjuries()
end, false)

exports('GetInjuries', function()
    return currentInjuries
end)

exports('ClearInjuries', function()
    for k in pairs(currentInjuries) do currentInjuries[k] = false end
    sendInjuries()
end)

exports('SetInjury', function(part, state)
    if currentInjuries[part] ~= nil then
        currentInjuries[part] = state and true or false
        sendInjuries()
    end
end)

