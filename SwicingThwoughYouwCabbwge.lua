-- UI by Inori, maintained by Wally
local repo = 'https://raw.githubusercontent.com/uwuscutely/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local HumanoidRP = Player.Character:FindFirstChild("HumanoidRootPart")
local PlayerGui = Player:WaitForChild("PlayerGui")

local AcceptQuest = ReplicatedStorage.Remotes.Quests:WaitForChild("AcceptQuest")
local AbandonQuest = ReplicatedStorage.Remotes.Quests:WaitForChild("AbandonQuest")
local CompleteQuest = ReplicatedStorage.Remotes.Quests:WaitForChild("CompleteQuest")
local OpenEgg = ReplicatedStorage.Remotes.Eggs:WaitForChild("OpenEgg")
local OpenChest = ReplicatedStorage.Remotes.Chests:WaitForChild("OpenChest")
local BuyAllWeapons = ReplicatedStorage.Remotes.Shop:WaitForChild("BuyAllWeapons")
local BuyAllAuras = ReplicatedStorage.Remotes.Shop:WaitForChild("BuyAllAuras")
local BuyClass = ReplicatedStorage.Remotes.Shop:WaitForChild("BuyClass")
local CreateProjectile = ReplicatedStorage.Remotes.Spellblades:WaitForChild("CreateProjectile")
local ProjectileHit = ReplicatedStorage.Remotes.Spellblades:WaitForChild("ProjectileHit")

if PlayerGui.MainUI.BottomCenter.Spellblade.ImageColor3 ~= Color3.fromRGB(98, 53, 23) then
    VirtualInputManager:SendKeyEvent(true, "One", false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, "One", false, game)
end

task.wait(1)

local projectileScript = Character:FindFirstChildOfClass("Tool"):FindFirstChildOfClass("LocalScript")
local projectileFunction

for i, v in pairs(getgc()) do
    if type(v) == "function" and islclosure(v) then
        if getfenv(v).script == projectileScript then
            local upvalues = debug.getupvalues(v)

            if upvalues[1] == HttpService then
                projectileFunction = v
                break
            end
        end
    end
end

ver = '2.1.0'

Library:Notify('Loading Swicing Thwough Youw Cabbwge v'..ver, 1)

local Window = Library:CreateWindow({
    Title = 'UwU | Swicing Thwough Youw Cabbwge v'..ver,
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Auto Farm')
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('Auto Open')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Teleport')
local RightGroupBox2 = Tabs.Main:AddRightGroupbox('Player')

--[[LeftGroupBox:AddToggle('AutoSwing', {
    Text = 'Auto Swing',
    Default = false,
    Tooltip = 'Automaticawwy swings youw swowd (swightwy quickew than the gawme\'s cwappy owne).',
}):AddKeyPicker('AutoSwingKey',{
    Default = 'C',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Swing',
    NoUI = false,
})]]

LeftGroupBox:AddToggle('AutoAttack', {
    Text = 'Auto Attack',
    Default = false,
    Tooltip = 'Spam the shit out of the attack bc dev made the function cwient side.',
}):AddKeyPicker('AutoAttackKey',{
    Default = 'B',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Attack',
    NoUI = false,
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('TowerKillAura', {
    Text = 'Tower Kill Aura',
    Default = false,
    Tooltip = 'Spam attack own aww mobs at the same time bc we\'we gigachad.',
}):AddKeyPicker('TowerKillAuraKey',{
    Default = 'K',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Tower Kill Aura',
    NoUI = false,
})

LeftGroupBox:AddSlider('TowerKillAuraDelay', {
    Text = 'Tower Kill Aura Delay',
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Compact = false,
})

LeftGroupBox:AddToggle('WorldKillAura', {
    Text = 'World Kill Aura',
    Default = false,
    Tooltip = 'Spam attack own aww mobs at the same time bc we\'we gigachad.',
}):AddKeyPicker('WorldKillAuraKey',{
    Default = 'L',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'World Kill Aura',
    NoUI = false,
})

LeftGroupBox:AddSlider('WorldKillAuraDelay', {
    Text = 'World Kill Aura Delay',
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Compact = false,
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddToggle('AutoPurchase', {
    Text = 'Auto Purchase',
    Default = false,
    Tooltip = 'Automaticawwy buys all weapons, auras, and classes.',
}):AddKeyPicker('AutoPurchaseKey',{
    Default = 'P',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Purchase',
    NoUI = false,
})

LeftGroupBox2:AddToggle('AutoOpenTP', {
    Text = 'Auto Open Teleport',
    Default = false,
    Tooltip = 'Tewepowts uwu between the egg awnd the chest.',
}):AddKeyPicker('AutoOpenTPKey',{
    Default = 'L',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Open Teleport Key',
    NoUI = false,
})

LeftGroupBox2:AddSlider('AutoOpenTPDelay', {
    Text = 'Auto Open TP Delay',
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Compact = false,
})

LeftGroupBox:AddDivider()

LeftGroupBox2:AddDropdown('EggType', {
    Values = { 'Demonic','Exotic', 'Mythical', 'Legendary', 'Epic', 'Rare', 'Common' },
    Default = 1,
    Multi = false,
    Text = 'Egg Type',
    Tooltip = 'Sewect the egg uwu wawnt tuwu hatch.',
})

LeftGroupBox2:AddToggle('AutoEgg', {
    Text = 'Auto Hatch',
    Default = false,
    Tooltip = 'Automaticawwy hatches eggs.',
}):AddKeyPicker('AutoEggKey',{
    Default = 'E',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Egg',
    NoUI = false,
})

LeftGroupBox:AddDivider()

LeftGroupBox2:AddDropdown('ChestType', {
    Values = { 'Legendary', 'Epic', 'Rare', 'Common' },
    Default = 1,
    Multi = false,
    Text = 'Egg Type',
    Tooltip = 'Sewect the chwest uwu wawnt tuwu hatch.',
})

LeftGroupBox2:AddToggle('AutoChest', {
    Text = 'Auto Chest',
    Default = false,
    Tooltip = 'Automaticawwy opens chwests.',
}):AddKeyPicker('AutoChestKey',{
    Default = 'E',
    SyncToggleState = true, 
    Mode = 'Toggle',
    Text = 'Auto Egg',
    NoUI = false,
})

--[[Toggles.AutoSwing:OnChanged(function()
    while Toggles.AutoSwing.Value do
        local mouse = UserInputService:GetMouseLocation()
        VirtualInputManager:SendMouseButtonEvent(mouse.x, mouse.y, 0, true, game, 0)
        task.wait()
        VirtualInputManager:SendMouseButtonEvent(mouse.x, mouse.y, 0, false, game, 0)
    end
end)]]

Toggles.AutoAttack:OnChanged(function()
    while Toggles.AutoAttack.Value do
        projectileFunction()
        task.wait()
    end
end)

Toggles.TowerKillAura:OnChanged(function()
    while Toggles.TowerKillAura.Value do
        for _,v in pairs (Workspace.TowerOfHeaven.Mobs:GetChildren()) do
            local generatedID = HttpService:GenerateGUID(false)
            local color = {
                ["color"] = Character:FindFirstChild("WeaponModel").Blade.Color
            }

            if v.HumanoidRootPart then
                CreateProjectile:FireServer(generatedID, v.HumanoidRootPart.CFrame, color)
                ProjectileHit:FireServer(generatedID, v)
            end
        end
        task.wait(Options.TowerKillAuraDelay.Value)
    end
end)

Toggles.WorldKillAura:OnChanged(function()
    while Toggles.WorldKillAura.Value do
        for _,v in pairs (Workspace.Mobs:GetChildren()) do
            local generatedID = HttpService:GenerateGUID(false)
            local color = {
                ["color"] = Character:FindFirstChild("WeaponModel").Blade.Color
            }
            
            if v.HumanoidRootPart then
                CreateProjectile:FireServer(generatedID, v.HumanoidRootPart.CFrame, color)
                ProjectileHit:FireServer(generatedID, v)
            end
        end
        task.wait(Options.WorldKillAuraDelay.Value)
    end
end)

Toggles.AutoOpenTP:OnChanged(function()
    while Toggles.AutoOpenTP.Value do
        HumanoidRP.CFrame = CFrame.new(218, 1, -61)
        task.wait(Options.AutoOpenTPDelay.Value)
        HumanoidRP.CFrame = CFrame.new(167, 0, 48)
        task.wait(Options.AutoOpenTPDelay.Value)
    end
end)

Toggles.AutoEgg:OnChanged(function()
    while Toggles.AutoEgg.Value do
        OpenEgg:InvokeServer(Options.EggType.Value.." Egg", 3)
        task.wait()
    end
end)

Toggles.AutoChest:OnChanged(function()
    while Toggles.AutoChest.Value do
        OpenChest:InvokeServer(Options.ChestType.Value.." Chest", 3)
        task.wait()
    end
end)

Toggles.AutoPurchase:OnChanged(function()
    while Toggles.AutoPurchase.Value do
        local currentClass = Player.PlayerData.Equipped:GetAttribute("Class")

        BuyClass:InvokeServer(currentClass + 1)
        BuyAllWeapons:InvokeServer()

        task.wait(1)

        BuyClass:InvokeServer(currentClass + 1)
        BuyAllAuras:InvokeServer()

        if PlayerGui.MainUI.BottomCenter.Spellblade.ImageColor3 ~= Color3.fromRGB(98, 53, 23) then
            VirtualInputManager:SendKeyEvent(true, "One", false, game)
            task.wait()
            VirtualInputManager:SendKeyEvent(false, "One", false, game)
        end
    end
end)

RightGroupBox:AddButton("Spawn", function() HumanoidRP.CFrame = CFrame.new(-569, 130, 150) end)
RightGroupBox:AddButton("Crystal Leaderboard", function() HumanoidRP.CFrame = CFrame.new(-344, 125, 106) end)
RightGroupBox:AddButton("Tower", function() HumanoidRP.CFrame = CFrame.new(-8525, 145, -272) end)
RightGroupBox:AddButton("Mythical Egg", function() HumanoidRP.CFrame = CFrame.new(-8528, 146, -236) end)

RightGroupBox2:AddSlider('Walkspeed', {
    Text = 'Walkspeed',
    Default = 20,
    Min = 0,
    Max = 69,
    Rounding = 1,
    Compact = false,
})

Options.Walkspeed:OnChanged(function()
    Player.Character.Humanoid.WalkSpeed = Options.Walkspeed.Value
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
SaveManager:SetFolder('RawrX3Nuzzles/Bullshit')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
Library:Notify('Loaded Swicing Thwough Youw Cabbwge v'..ver..'! Meow meow ^-^', 5)

-- Update checker from https://github.com/EdgeIY/infiniteyield
task.spawn(function()
    Library:Notify('Running update check!', 1)
    while true do
        if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/uwuscutely/Scripts/main/Version'))() end) then
            if ver ~= BSVersion then
                Library:Notify('Your current version of Swicing Thwough Youw Cabbwge is outdated!\n\nYour version: '..ver..'\nLatest version: '..BSVersion..'\n\nGrab the latest version by re-executing the script!', 25)
            end
        end
        task.wait(30)
    end
end)

if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/uwuscutely/Scripts/main/Version'))() end) then
    if ver == BSVersion then
        Library:Notify('You\'re running the latest verion of Swicing Thwough Youw Cabbwge!', 5)
    end
end

-- RGB gradient from https://github.com/violin-suzutsuki/LinoriaLib
Toggles.Rainbow:OnChanged(function()
    task.spawn(function()
        while Toggles.Rainbow.Value do
            task.wait()
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

        if not Toggles.Rainbow.Value then
            ThemeManager:UpdateTheme()
        end
    end)
end)
