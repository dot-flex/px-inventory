PxInventory = {
    -- Inventory framework; profile adapters: esx, qbcore, qbox.
    Framework = 'auto',
    Discord = {
        -- Enable Discord avatars. Bot token and Guild ID from server.cfg.
        Enabled = true,
        -- Avatar image size: 64, 128, 256 or 512 pix.
        AvatarSize = 128,

        CacheSeconds = 900,

        RetrySeconds = 60
    },
    Accounts = {
        -- ESX cash account name.
        ESXCash = 'money',
        -- QBCore/Qbox cash account name.
        QBCash = 'cash',
        -- Framework bank account name.
        Bank = 'bank'
    },

    RequestCooldown = 2
}
