# OX INVENTORY REDESIGN

**Modern 3D UI Redesign for Ox Inventory**

![FiveM](https://img.shields.io/badge/FiveM-OX_Inventory_Redesign-c0ef19?style=flat-square)
![Frameworks](https://img.shields.io/badge/frameworks-ESX_%7C_QBCore_%7C_Qbox_%7C_OX-44cc11?style=flat-square)
![OneSync](https://img.shields.io/badge/OneSync-required-007ec6?style=flat-square)
[![License](https://img.shields.io/badge/license-GPL--3.0-orange?style=flat-square)](LICENSE)

## ✨ Features

- **3D Perspective Grids** - Inward-angled 3D layout for player and secondary inventories.
- **Tactical Cut Slots** - Angled notch cut slot design with clean contrast and depth.
- **Body Injury Viewer** - Centered silhouette preview tracking real-time damage across head, torso, arms, and legs. Fully compatible across **ESX**, **QBCore**, and **Qbox**.
- **Profile Header** - Displays character name, Discord avatar, cash in wallet, and bank balance.
- **Refined Hotbar** - Minimalist bottom bar with clean 1–5 hotkey badges.
- **Segmented Weight & Durability** - Modern masked weight bar and vertical durability indicators.
- **Built-in Settings** - Custom UI scale (75%–110%), background blur/opacity, and theme accent colors.

## 📦 Dependencies

- **OneSync** enabled
- **[ox_lib](https://github.com/overextended/ox_lib)**
- **[ox_target](https://github.com/overextended/ox_target)** *(optional, for shop peds)*
- **Supported Frameworks:**

| Framework | Core | Notes |
| --- | --- | --- |
| ESX | es_extended | Works on all recent ESX Legacy versions |
| QBCore | qb-core | Compatible via qb-core bridge |
| Qbox | qbx_core | Native Qbox exports and player metadata |
| OX Core | ox_core | Native support |

## ⚙️ Installation

1. Place the files into your resource folder:
   ```text
   resources/[ox]/ox_inventory
   ```

2. Start it after `ox_lib` in your `server.cfg`:
   ```cfg
   ensure ox_lib
   ensure ox_target 
   ensure ox_inventory
   ```

3. Restart the server or run:
   ```cfg
   refresh
   ensure ox_inventory
   ```

## 🎮 Controls

| Key / Command | Action |
| --- | --- |
| `F2` / `TAB` | Open / Close inventory |
| `1` - `5` | Use hotbar item |
| `Left Click` | Drag & move items |
| `Right Click` | Quick transfer item |
| `Shift + Left Click` | Transfer full stack |
| `Middle Click` | Split stack |

## 🩹 Test Commands & Injury Exports

The body injury viewer works natively across all frameworks through GTA V bone detection. You can test and toggle parts using chat/console commands:

| Command | Action |
| --- | --- |
| `/testinjury head` | Toggle head injury |
| `/testinjury torso` | Toggle torso injury |
| `/testinjury left_arm` | Toggle left arm injury |
| `/testinjury right_arm` | Toggle right arm injury |
| `/testinjury left_leg` | Toggle left leg injury |
| `/testinjury right_leg` | Toggle right leg injury |
| `/testinjury all` | Highlight all body parts |
| `/testinjury clear` | Reset and clear all active injuries |

### Developer Exports

```lua
local injuries = exports.ox_inventory:GetInjuries()
exports.ox_inventory:SetInjury('head', true)
exports.ox_inventory:ClearInjuries()
```

## 🎨 UI Settings

Accessible in-game via the settings button:
- **UI Scale:** Adjust slot and text size from 75% to 110%.
- **Background Opacity:** Set how much the game world dims behind the inventory.
- **Theme Accent:** Choose custom color themes for slot outlines, glow, and scrollbar.

## 📷 Showcase

![Showcase 1](https://i.ibb.co/HTLvx5DN/image.png)
![Showcase 2](https://i.ibb.co/3mvwDx8f/image.png)
![Showcase 3](https://i.ibb.co/c947V0W/image.png)

## 📜 Credits

- **[Overextended](https://github.com/overextended)** - Original `ox_inventory`
- **Redesign** - Custom NUI layout, styling, and body damage viewer.
