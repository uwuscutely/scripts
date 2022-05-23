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
local TabBox = Tabs.Main:AddRightTabbox()
local Ability1 = TabBox:AddTab('Auto Ability #1')
local Ability2 = TabBox:AddTab('Auto Ability #2')


LeftGroupBox:AddToggle('AutoPickup', {
    Text = 'Auto Pickup',
    Default = false,
    Tooltip = 'Automatically pickup items epic tier or above, portal scrolls, and currency.',
})

LeftGroupBox:AddDropdown('AutoPickupSelection', {
    Values = { 'Epics', 'Legendaries', 'Mythics', 'Portals', "Currency"},
    Default = 1, 
    Multi = true,
    Text = 'A dropdown',
    Tooltip = 'This is a tooltip',
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
    syn.request(
        {
            Url = "https://discord.com/api/webhooks/978180313798832128/-fEPtzZuyoHO1c0d7-oG_YkPnTMh6ixfyBfyaw0i2Y8LGG-Zwkm_WUQzBZ_8rEHHcFqF",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                content = "<@118191838925422597> <@372468580643635211> Brooooo!! You just dropped an OP item!!",
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
end

Toggles.AutoPickup:OnChanged(function()
    while Toggles.AutoPickup.Value do
        task.wait()
        for _,v in pairs(lootLabels:GetChildren()) do
            if v.Visible == true then
                local color = v.BackgroundColor3:ToHex()
                local rarity = colorToRarity(color)
                local item = v.ItemName.Text
                if color == Color3.fromRGB(249, 86, 59):ToHex() or color == Color3.fromRGB(255, 255, 255):ToHex() or v.Name:match("Portal") or v.Name:match("Copper") then
                    task.wait()
                    PickUpItem:InvokeServer(v.Name)
                    webhookPing(item, rarity)
                end
            end
        end
    end
end)

LeftGroupBox:AddLabel('Never gonna give you up, never gonna let you down, never gonna run around and desert you...', true)
LeftGroupBox:AddLabel('A ship shipping ship ships shipping ships...', true)

Ability1:AddToggle('Ability1', {
    Text = 'Auto Ability #1',
    Default = false,
    Tooltip = 'Automatically use your first ability.',
})

Ability1:AddSlider('Ability1Timer', {
    Text = 'Ability #1 Delay (Seconds)',
    Default = 1,
    Min = 0.1,
    Max = 60,
    Rounding = 2,
    Compact = false,
})

Ability1:AddLabel('Ability #1 Keybind'):AddKeyPicker('Ability1Keybind', {
    SyncToggleState = false, 
    Mode = 'Hold',
    Text = 'Define auto ability #1\'s keybind',
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

Ability2:AddToggle('Ability2', {
    Text = 'Auto Ability #2',
    Default = false,
    Tooltip = 'Automatically use your second ability.',
})

Ability2:AddSlider('Ability2Timer', {
    Text = 'Ability #2 Delay (Seconds)',
    Default = 1,
    Min = 0.1,
    Max = 60,
    Rounding = 2,
    Compact = false,
})

Ability2:AddLabel('Ability #2 Keybind'):AddKeyPicker('Ability2Keybind', {
    SyncToggleState = false, 
    Mode = 'Hold',
    Text = 'Define auto ability #2\'s keybind',
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
    print('Unloaded!')
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
