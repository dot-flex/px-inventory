# PX Inventory

Loaded automatically by ox_inventory. This folder is not a separate resource.

## Discord

Add to your main server.cfg before ensure ox_inventory:

```cfg
set inventory:discordBotToken "YOUR_BOT_TOKEN"
set inventory:discordGuildId "YOUR_DISCORD_SERVER_ID"
```

Use set, never setr or sets. Restart the server after editing server.cfg. Keep the real token out of files.

The bot and player must be in the configured Discord server. The player needs a Discord identifier in FiveM. The server avatar is preferred; the global avatar is used when no server avatar exists.

Run px_inventory_discord in the server console to check avatar lookup without printing the token.