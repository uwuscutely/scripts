-- UI by Inori, maintained by Wally
local repo = 'https://raw.githubusercontent.com/uwuscutely/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local slots = PlayerGui.ScreenGui.Inventory.Slots
local lootLabels = PlayerGui.LootLabel

local PickUpItem = ReplicatedStorage.Knit.Services.GroundItemService.RF.PickUpItem
local SellingItems = ReplicatedStorage.Knit.Services.ShopSellService.RF.SellingItems
local InputReceived = ReplicatedStorage.Knit.Services.ActionBarService.RE.InputReceived

ver = '1.5.0'

Library:Notify('Loading Mewobwox Utiwities v'..ver, 5)

local Window = Library:CreateWindow({
    Title = 'UwU | Mewobwox Utiwities v'..ver,
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Auto Pickup')
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('Notifwer Settwings')
local LeftGroupBox3 = Tabs.Main:AddLeftGroupbox('Auto Seww')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Auto Abiwity')
local UpdateGroupBox = Tabs.Main:AddRightGroupbox('Update Log')

UpdateGroupBox:AddLabel('+ Updated auto sell to prevent rare+ pets and epic+ eggs from deletion.\n', true)
UpdateGroupBox:AddLabel('+ Updated auto ability to directly fire the action remote. Keybind input removed.\n', true)
UpdateGroupBox:AddLabel('+ Implemented automatic update checker. Will notify if out of date.\n', true)
UpdateGroupBox:AddLabel('+ Added RGB accent colors. Toggleable in UI Settings tab.\n', true)

LeftGroupBox:AddToggle('AutoPickup', {
    Text = 'Auto Pickup',
    Default = false,
    Tooltip = 'Automaticawwy pickup items epic tiew ow above, powtal scwolls, awnd cuwwency.',
})

LeftGroupBox:AddLabel('\nAuto pickup\'s common option will pickup potions, scrolls, and stones. You don\'t need to select those on top of the common option.\n', true)

LeftGroupBox:AddDropdown('AutoPickupSelection', {
    Values = {'Common', 'Uncommon', 'Rare', 'Epic', 'Legendary', 'Mythic', 'City Portal', "Currency", "Regret Stone"},
    Default = 1, 
    Multi = true,
    Text = 'Auto Pickup Sewection',
    Tooltip = 'Sewect whawt the auto pickup shouwd pickup.',
})

local function colorToRarity(rarity)
    local itemRarity
    if rarity == Color3.fromRGB(121, 137, 142):ToHex() then
        itemRarity = "Common"
        return itemRarity
    elseif rarity == Color3.fromRGB(52, 202, 73):ToHex() then
        itemRarity = "Uncommon"
        return itemRarity
    elseif rarity == Color3.fromRGB(5, 128, 233):ToHex() then
        itemRarity = "Rare"
        return itemRarity
    elseif rarity == Color3.fromRGB(158, 59, 249):ToHex() then
        itemRarity = "Epic"
        return itemRarity
    elseif rarity == Color3.fromRGB(249, 86, 59):ToHex() then
        itemRarity = "Legendary"
        return itemRarity
    elseif rarity == Color3.fromRGB(255, 255, 255):ToHex() then
        itemRarity = "Mythic"
        return itemRarity
    end
end

local function webhookPing(item, rarity)
    if Toggles.WebhookToggle.Value then
        pcall(function()
            syn.request(
                {
                    Url = Options.WebhookLink.Value,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode({
                        content = "<@118191838925422597> <@372468580643635211> Brooooo!! You just dropped an OP item!! (The reality is it's probably :poop:)",
                        embeds = {
                            {
                                title = "Mewobwox Woot Notifwer",
                                description = "```Item: "..item.."\nRarity: "..rarity.."```",
                                color = 8577791
                            }
                        }
                    })
                }
            )
        end)
    else
        return
    end
end

Toggles.AutoPickup:OnChanged(function()
    while Toggles.AutoPickup.Value do
        task.wait()
        for _,v in pairs(lootLabels:GetChildren()) do
            if v.Visible == true then
                pcall(function()
                    local color = v.BackgroundColor3:ToHex()
                    local rarity = colorToRarity(color)
                    local item = v.ItemName.Text
                    
                    if color == Color3.fromRGB(121, 137, 142):ToHex() and Options.AutoPickupSelection.Value["Common"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                    end

                    if color == Color3.fromRGB(52, 202, 73):ToHex() and Options.AutoPickupSelection.Value["Uncommon"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                    end

                    if color == Color3.fromRGB(5, 128, 233):ToHex() and Options.AutoPickupSelection.Value["Rare"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                    end

                    if color == Color3.fromRGB(158, 59, 249):ToHex() and Options.AutoPickupSelection.Value["Epic"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                        pcall(webhookPing, item, rarity)
                    end
    
                    if color == Color3.fromRGB(249, 86, 59):ToHex() and Options.AutoPickupSelection.Value["Legendary"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                        pcall(webhookPing, item, rarity)
                    end
                    
                    if color == Color3.fromRGB(255, 255, 255):ToHex() and Options.AutoPickupSelection.Value["Mythic"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                        pcall(webhookPing, item, rarity)
                    end
    
                    if item:match("Portal") and Options.AutoPickupSelection.Value["City Portal"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                    end
                    
                    if item:match("Copper") and Options.AutoPickupSelection.Value["Currency"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                    end
    
                    if item:match("Regret") and Options.AutoPickupSelection.Value["Regret Stone"] then
                        task.wait(0.5)
                        PickUpItem:InvokeServer(v.Name)
                    end
                end)
            end
        end
    end
end)

--[[
LeftGroupBox:AddLabel('\nNever gonna give you up, never gonna let you down, never gonna run around and desert you...', true)
LeftGroupBox:AddLabel('\nA ship shipping ship ships shipping ships...', true)
]]


LeftGroupBox2:AddToggle('WebhookToggle', {
    Text = 'Enabwe Webhook',
    Default = false,
    Tooltip = 'Pings uwu fow item dwops pickup up excwuding powtals awnd cuwwency.',
})

LeftGroupBox2:AddInput('WebhookLink', {
    Default = 'Notifiew Webhook Wink',
    Numeric = false,
    Finished = true,
    Text = 'Notifiew Webhook Wink',
    Tooltip = 'Paste youw Discowd webhook wink hewe.',
    Placeholder = 'Webhook Wink Here',
})

LeftGroupBox3:AddToggle('AutoSell', {
    Text = 'Auto Seww ',
    Default = false,
    Tooltip = 'Automaticawwy sell your shit',
})

LeftGroupBox3:AddDropdown('AutoSellSelection', {
    Values = { 'Common', 'Uncommon', 'Rare', 'Epic'},
    Default = 1, 
    Multi = true,
    Text = 'Auto Seww Sewection',
    Tooltip = 'Sewect whawt the auto seww shouwd seww.',
})

Toggles.AutoSell:OnChanged(function()
    while Toggles.AutoSell.Value do
        task.wait()
        for _,v in pairs(slots:GetChildren()) do
            local sellTable = {}
            local item = v:FindFirstChild("Item")

            if item then
                pcall(function()
                    local color = item.Button.BackgroundColor3:ToHex()
                    local itemID = item:GetAttribute("ItemID")
                    local itemName = item:GetAttribute("Name")
                    local itemSlot = item.Parent.Name

                    if color == Color3.fromRGB(121, 137, 142):ToHex() and Options.AutoSellSelection.Value["Common"] and not itemName:match("Portal") and not itemName:match("Regret") then
                        sellTable[itemID] = itemSlot
                    end

                    if color == Color3.fromRGB(52, 202, 73):ToHex() and Options.AutoSellSelection.Value["Uncommon"] then
                        sellTable[itemID] = itemSlot
                    end

                    if color == Color3.fromRGB(5, 128, 233):ToHex() and Options.AutoSellSelection.Value["Rare"] and not itemName:match("Pet") then
                        sellTable[itemID] = itemSlot
                    end

                    if color == Color3.fromRGB(158, 59, 249):ToHex() and Options.AutoSellSelection.Value["Epic"] and not itemName:match("Egg") and not itemName:match("Pet") then
                        sellTable[itemID] = itemSlot
                    end

                    if next(sellTable) ~= nil then
                        SellingItems:InvokeServer(sellTable)
                    end
                end)
            end
        end
        task.wait(10)
    end
end)

LeftGroupBox3:AddLabel('\nSelling commons doesn\'t include portals or regret stones. Common potions (health/mana) will be sold. Rare+ pets and epic+ eggs will not be sold.', true)

local SellNow = LeftGroupBox3:AddButton('Sell Now', function()
    for _,v in pairs(slots:GetChildren()) do
        local sellTable = {}
        local item = v:FindFirstChild("Item")

        if item then
            pcall(function()
                local color = item.Button.BackgroundColor3:ToHex()
                local itemID = item:GetAttribute("ItemID")
                local itemName = item:GetAttribute("Name")
                local itemSlot = item.Parent.Name

                if color == Color3.fromRGB(121, 137, 142):ToHex() and Options.AutoSellSelection.Value["Common"] and not itemName:match("Portal") and not itemName:match("Regret") then
                    sellTable[itemID] = itemSlot
                end

                if color == Color3.fromRGB(52, 202, 73):ToHex() and Options.AutoSellSelection.Value["Uncommon"] then
                    sellTable[itemID] = itemSlot
                end

                if color == Color3.fromRGB(5, 128, 233):ToHex() and Options.AutoSellSelection.Value["Rare"] and not itemName:match("Pet") then
                    sellTable[itemID] = itemSlot
                end

                if color == Color3.fromRGB(158, 59, 249):ToHex() and Options.AutoSellSelection.Value["Epic"] and not itemName:match("Egg") and not itemName:match("Pet") then
                    sellTable[itemID] = itemSlot
                end

                if next(sellTable) ~= nil then
                    SellingItems:InvokeServer(sellTable)
                end
            end)
        end
    end
end)

RightGroupBox:AddToggle('Ability1', {
    Text = 'Auto Abiwity #1',
    Default = false,
    Tooltip = 'Automaticawwy use your first abiwity.',
})

RightGroupBox:AddSlider('Ability1Timer', {
    Text = 'Abiwity #1 Delay (Seconds)',
    Default = 21,
    Min = 0.1,
    Max = 30,
    Rounding = 2,
    Compact = false,
})

Toggles.Ability1:OnChanged(function()
    while Toggles.Ability1.Value do
        InputReceived:FireServer("Action2", "Down")
        task.wait()
        InputReceived:FireServer("Action2", "Up")
        task.wait(Options.Ability1Timer.Value)
    end
end)

RightGroupBox:AddDivider()

RightGroupBox:AddToggle('Ability2', {
    Text = 'Auto Abiwity #2',
    Default = false,
    Tooltip = 'Automaticawwy use your second abiwity.',
})

RightGroupBox:AddSlider('Ability2Timer', {
    Text = 'Abiwity #2 Delay (Seconds)',
    Default = 21,
    Min = 0.1,
    Max = 30,
    Rounding = 2,
    Compact = false,
})

Toggles.Ability2:OnChanged(function()
    while Toggles.Ability2.Value do
        InputReceived:FireServer("Action3", "Down")
        task.wait()
        InputReceived:FireServer("Action3", "Up")
        task.wait(Options.Ability2Timer.Value)
    end
end)

Library:SetWatermarkVisibility(true)
Library:SetWatermark('Meow Meow UwU ^_^')

Library.KeybindFrame.Visible = false

Library:OnUnload(function()
    print('Unwoaded!')
    Library.Unloaded = true
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload UI', function() Library:Unload() end)
MenuGroup:AddLabel('Menu Toggle'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu Toggle' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:SetFolder('RawrX3Nuzzles')
SaveManager:SetFolder('RawrX3Nuzzles/Mewobwox')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
Library:Notify('Loaded Mewobwox Utiwities v'..ver..'! Meow meow ^-^', 5)

-- RGB gradient from https://github.com/violin-suzutsuki/LinoriaLib
task.spawn(function()
    while game:GetService('RunService').RenderStepped:Wait() do
        if Toggles.Rainbow.Value then
            local Registry = Window.Holder.Visible and Library.Registry or Library.HudRegistry

            for Idx, Object in next, Library.Registry do
                for Property, ColorIdx in next, Object.Properties do
                    if ColorIdx == 'AccentColor' or ColorIdx == 'AccentColorDark' then
                        local Instance = Object.Instance
                        local yPos = Instance.AbsolutePosition.Y

                        local Mapped = Library:MapValue(yPos, 0, 1080, 0, 0.5) * 1.5
                        local Color = Color3.fromHSV((Library.CurrentRainbowHue - Mapped) % 1, 0.8, 1)

                        if ColorIdx == 'AccentColorDark' then
                            Color = Library:GetDarkerColor(Color)
                        end

                        Instance[Property] = Color
                    end
                end
            end
        end
    end
end)

-- Update checker from https://github.com/EdgeIY/infiniteyield
task.spawn(function()
    Library:Notify('Running update check!', 2)
    while true do
        if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/uwuscutely/Scripts/main/Version'))() end) then
            if ver ~= MUVersion then
                Library:Notify('Your current version of Mewobwox Utiwities is outdated!\n\n Your version: '..ver..'\nLatest version: '..MUVersion..'\n\nGrab the latest version by re-executing the script!', 45)
            end
        end
        task.wait(60)
    end
end)

if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/uwuscutely/Scripts/main/Version'))() end) then
    if ver == MUVersion then
        Library:Notify('You\'re running the latest verion of Mewobwox Utiwities!', 5)
    end
end
