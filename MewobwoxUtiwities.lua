local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local lootLabels = PlayerGui.LootLabel
local PickUpItem = ReplicatedStorage.Knit.Services.GroundItemService.RF.PickUpItem

local Window = Library:CreateWindow({
    Title = 'UwU | Mewobwox Utiwities',
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Auto Pickup')
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('Notifwer Settwings')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Auto Abiwity')

LeftGroupBox:AddToggle('AutoPickup', {
    Text = 'Auto Pickup',
    Default = false,
    Tooltip = 'Automaticawwy pickup items epic tiew ow above, powtal scwolls, awnd cuwwency.',
})

LeftGroupBox:AddDropdown('AutoPickupSelection', {
    Values = { 'Epics', 'Legendaries', 'Mythics', 'Portals', "Currency", "Regret Stones"},
    Default = 1, 
    Multi = true,
    Text = 'Auto Pickup Sewection',
    Tooltip = 'Sewect whawt the auto pickup shouwd pickup.',
})

local function colorToRarity(rarity)
    local itemRarity
    if rarity == Color3.fromRGB(158, 59, 249):ToHex() then
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
                local color = v.BackgroundColor3:ToHex()
                local rarity = colorToRarity(color)
                local item = v.ItemName.Text

                if color == Color3.fromRGB(158, 59, 249):ToHex() and Options.AutoPickupSelection.Value["Epics"] then
                    task.wait(0.5)
                    PickUpItem:InvokeServer(v.Name)
                    pcall(webhookPing, item, rarity)
                end

                if color == Color3.fromRGB(249, 86, 59):ToHex() and Options.AutoPickupSelection.Value["Legendaries"] then
                    task.wait(0.5)
                    PickUpItem:InvokeServer(v.Name)
                    pcall(webhookPing, item, rarity)
                end
                
                if color == Color3.fromRGB(255, 255, 255):ToHex() and Options.AutoPickupSelection.Value["Mythics"] then
                    task.wait(0.5)
                    PickUpItem:InvokeServer(v.Name)
                    pcall(webhookPing, item, rarity)
                end

                if item:match("Portal") and Options.AutoPickupSelection.Value["Portals"] then
                    task.wait(0.5)
                    PickUpItem:InvokeServer(v.Name)
                end
                
                if item:match("Copper") and Options.AutoPickupSelection.Value["Currency"] then
                    task.wait(0.5)
                    PickUpItem:InvokeServer(v.Name)
                end

                if item:match("Regret") and Options.AutoPickupSelection.Value["Regret Stones"] then
                    task.wait(0.5)
                    PickUpItem:InvokeServer(v.Name)
                end
            end
        end
    end
end)

LeftGroupBox:AddLabel('\nNever gonna give you up, never gonna let you down, never gonna run around and desert you...', true)
LeftGroupBox:AddLabel('\nA ship shipping ship ships shipping ships...', true)

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

RightGroupBox:AddLabel('Ability #1 Keybind'):AddKeyPicker('Ability1Keybind', {
    SyncToggleState = false, 
    Mode = 'Hold',
    Text = 'Define auto abiwity #1\'s keybind',
    NoUI = true,
})

Toggles.Ability1:OnChanged(function()
    while Toggles.Ability1.Value do
        VirtualInputManager:SendKeyEvent(true, Options.Ability1Keybind.Value, false, game)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Options.Ability1Keybind.Value, false, game)
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

RightGroupBox:AddLabel('Ability #2 Keybind'):AddKeyPicker('Ability2Keybind', {
    SyncToggleState = false, 
    Mode = 'Hold',
    Text = 'Define auto abiwity #2\'s keybind',
    NoUI = true,
})

Toggles.Ability2:OnChanged(function()
    while Toggles.Ability2.Value do
        VirtualInputManager:SendKeyEvent(true, Options.Ability2Keybind.Value, false, game)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Options.Ability2Keybind.Value, false, game)
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
