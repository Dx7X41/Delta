-- [[ DELTA MOBILE COMPATIBLE CUSTOM HUB ]]
-- Uses an updated, mobile-optimized Orion source to guarantee rendering on Delta UI Layers

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Seven7-lua/Roblox/refs/heads/main/Librarys/Orion/Orion.lua')))()
local Players = game:GetService("Players")

-- Dynamic Target State Variables
local SelectedPlayer = nil
local TargetEveryone = false

-- [[ CENTRAL LOADSTRING ARRAY ]]
-- Paste your custom details and URLs directly into these sub-tables.
local ScriptDatabase = {
    ["Tab One Scripts"] = {
        {
            Name = "Bring All",
            Description = "Uses Toilets to bring everyone to you!",
            URL = "https://pastebin.com"
        },
        {
            Name = "Kill All",
            Description = "Kills Everyone with Toilets!",
            URL = "https://pastebin.com"
        },
        {
            Name = "Void All",
            Description = "Sends Everyone 55B studs away from you!",
            URL = "https://pastebin.com"
        }
    },
    ["Tab Two Scripts"] = {
        {
            Name = "Script Name C",
            Description = "Enter details or instructions for Script C.",
            URL = "https://pastebin.com"
        },
        {
            Name = "Script Name D",
            Description = "Enter details or instructions for Script D.",
            URL = "https://pastebin.com"
        }
    },
    ["Tab Three Scripts"] = {
        {
            Name = "Script Name E",
            Description = "Enter details or instructions for Script E.",
            URL = "https://pastebin.com"
        }
    }
}

-- Safe Execution Function wrapper
local function ExecuteCustomLoadstring(scriptName, url)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if success then
        OrionLib:MakeNotification({
            Name = "Execution Success",
            Content = "Fired up: " .. scriptName,
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    else
        OrionLib:MakeNotification({
            Name = "Execution Failure",
            Content = "Failed to run script. Check the console layer.",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        warn("Delta Engine Error [" .. scriptName .. "]: " .. tostring(err))
    end
end

-- Helper function to fetch active player list (excluding yourself)
local function GetPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    return names
end

-- [[ UI ENGINE INSTANTIATION ]]
local Window = OrionLib:MakeWindow({
    Name = "Astral X", 
    HidePremium = true, 
    SaveConfig = true, 
    ConfigFolder = "DeltaMobileConfigs"
})

-- [[ GENERATING TABS ]]

-- Tab 1
local Tab1 = Window:MakeTab({
    Name = "Troll",
    Icon = "rbxassetid://4483345998"
})

Tab1:AddSection({ Name = "Target System" })

-- Dropdown to choose a player
local PlayerDropdown = Tab1:AddDropdown({
    Name = "Select Target Player",
    Default = "None",
    Options = GetPlayerNames(),
    Callback = function(Value)
        SelectedPlayer = Value
        print("Astral X Target Set: " .. tostring(SelectedPlayer))
    end
})

-- Refresh button for server changes
Tab1:AddButton({
    Name = "Refresh Player List",
    Callback = function()
        PlayerDropdown:Refresh(GetPlayerNames(), true)
    end
})

-- Toggle switch for everyone
Tab1:AddToggle({
    Name = "Target Everyone",
    Default = false,
    Callback = function(Value)
        TargetEveryone = Value
        print("Astral X Target Everyone: " .. tostring(TargetEveryone))
    end
})

Tab1:AddSection({ Name = "Prop Abuse" })

for _, item in ipairs(ScriptDatabase["Tab One Scripts"]) do
    Tab1:AddButton({
        Name = item.Name,
        Callback = function()
            ExecuteCustomLoadstring(item.Name, item.URL)
        end
    })
end

-- Tab 2
local Tab2 = Window:MakeTab({
    Name = "Secondary Scripts",
    Icon = "rbxassetid://4483362458"
})
Tab2:AddSection({ Name = "Group 2 Options" })

for _, item in ipairs(ScriptDatabase["Tab Two Scripts"]) do
    Tab2:AddButton({
        Name = item.Name,
        Callback = function()
            ExecuteCustomLoadstring(item.Name, item.URL)
        end
    })
end

-- Tab 3
local Tab3 = Window:MakeTab({
    Name = "Advanced Scripts",
    Icon = "rbxassetid://4483362748"
})
Tab3:AddSection({ Name = "Group 3 Options" })

for _, item in ipairs(ScriptDatabase["Tab Three Scripts"]) do
    Tab3:AddButton({
        Name = item.Name,
        Callback = function()
            ExecuteCustomLoadstring(item.Name, item.URL)
        end
    })
end

-- [[ CONTROL LAYER SETTINGS ]]
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483362590"
})
SettingsTab:AddSection({ Name = "UI Controls" })

SettingsTab:AddButton({
    Name = "Unload Script",
    Callback = function()
        OrionLib:Destroy()
    end
})

-- Initialize the final GUI setup
OrionLib:Init()
