if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId == 9551640993 then    
    local repo = 'https://raw.githubusercontent.com/uwuscutely/LinoriaLib/main/'

    local Library = loadstring(game:HttpGet(repo..'Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet(repo..'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo..'addons/SaveManager.lua'))()

    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/uwuscutely/KiriotESPLib/main/ESP.lua"))()

    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local NetworkClient = game:GetService("NetworkClient")

    local LoadModule = require(ReplicatedStorage.LoadModule)
    local ChunkUtil = LoadModule("ChunkUtil")

    local PlaceTeleporter = ReplicatedStorage.Events:WaitForChild("PlaceTeleporter")
    local RemoveTeleporter = ReplicatedStorage.Events:WaitForChild("RemoveTeleporter")
    local GotoTeleporter = ReplicatedStorage.Events:WaitForChild("GotoTeleporter")
    local MineBlock = ReplicatedStorage.Events:WaitForChild("MineBlock")
    local Teleport = ReplicatedStorage.Events:WaitForChild("Teleport")
    local Rebirth = ReplicatedStorage.Events:WaitForChild("Rebirth")
    local OpenEgg = ReplicatedStorage.Events:WaitForChild("OpenEgg")
    local MultiDeletePets = ReplicatedStorage.Events:WaitForChild("MultiDeletePets")

    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")
    local humanoid = player.Character:WaitForChild("Humanoid")

    local pets = PlayerGui.ScreenGui.Inventory.Frame.Container.Pets.Content.Frame.Items
    local petNumber = 0
    local sellTable = {}

    ver = '1.0.0'

    Library:Notify('Loading Miners Heaven v'..ver, 2)

    ESP.Players = false
    ESP.Tracers = true

    ESP:AddObjectListener(Workspace.Decoration, {
        Name = "iridium",
        CustomName = "Iridium",
        Color = Color3.fromRGB(0, 89, 255),
        Type = "MeshPart",
        IsEnabled = "Iridium"
    })

    local Window = Library:CreateWindow({
        Title = 'UwU | Miners Heaven v'..ver,
        Center = true, 
        AutoShow = true,
    })

    local Tabs = {
        Main = Window:AddTab('Main'),
        ['UI Settings'] = Window:AddTab('UI Settings'),
    }

    local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Meow :>')

    LeftGroupBox:AddToggle('ESPToggle', {
        Text = 'X-Ray',
        Default = false,
        Tooltip = 'Automaticawwy shows uwu the cwosest wawe owes.',
    })

    Toggles.ESPToggle:OnChanged(function()
        if Toggles.ESPToggle.Value then
            ESP:Toggle(true)
            ESP.Iridium = true
        else
            ESP:Toggle(false)
            ESP.Iridium = false
        end
    end)

    LeftGroupBox:AddDivider()

    local function autoRebirth()
        local totalOres = 0

        while totalOres < Options.OresToMine.Value do
            local Larimar = Workspace.Decoration.larimar
            local LarimarPos = Larimar.Position
            local LarimarCell = ChunkUtil.worldToCell(LarimarPos)

            RemoveTeleporter:FireServer()
            PlaceTeleporter:FireServer(LarimarCell)
            GotoTeleporter:FireServer()
            MineBlock:FireServer(LarimarCell)

            totalOres += 1
            task.wait(1)
        end

        Teleport:FireServer("Crystal CavernSell")
        task.wait(1)
        Rebirth:FireServer()
    end

    LeftGroupBox:AddToggle('AutoRebirth', {
        Text = 'Auto Rebirth',
        Default = false,
        Tooltip = 'UwU',
    })

    Toggles.AutoRebirth:OnChanged(function()
        while Toggles.AutoRebirth.Value do
            autoRebirth()
            task.wait(2)
        end
    end)

    LeftGroupBox:AddSlider('OresToMine', {
        Text = 'Total Ores for Rebirth',
        Default = 0,
        Min = 0,
        Max = 15,
        Rounding = 0,
        Compact = false
    })

    LeftGroupBox:AddDivider()

    LeftGroupBox:AddToggle('AutoMineL', {
        Text = 'Auto Mine (Iridium)',
        Default = false,
        Tooltip = 'UwU',
    })

    LeftGroupBox:AddToggle('AutoMineFS', {
        Text = 'Auto Mine (Fire Shard)',
        Default = false,
        Tooltip = 'UwU',
    })

    Toggles.AutoMineL:OnChanged(function()
        while Toggles.AutoMineL.Value do
            local Larimar = Workspace.Decoration.iridium
            local LarimarPos = Larimar.Position
            local LarimarCell = ChunkUtil.worldToCell(LarimarPos)

            RemoveTeleporter:FireServer()
            PlaceTeleporter:FireServer(LarimarCell)
            GotoTeleporter:FireServer()
            MineBlock:FireServer(LarimarCell)

            task.wait(0.5)
        end
    end)

    Toggles.AutoMineFS:OnChanged(function()
        while Toggles.AutoMineFS.Value do
            local FireShard = Workspace.Decoration.fireshard
            local FireShardPos = FireShard.Position
            local FireShardCell = ChunkUtil.worldToCell(FireShardPos)

            RemoveTeleporter:FireServer()
            PlaceTeleporter:FireServer(FireShardCell)
            GotoTeleporter:FireServer()
            MineBlock:FireServer(FireShardCell)

            task.wait(0.5)
        end
    end)

    LeftGroupBox:AddDivider()

    LeftGroupBox:AddToggle('AutoEgg', {
        Text = 'Auto Egg',
        Default = false,
        Tooltip = 'UwU',
    })

    Toggles.AutoEgg:OnChanged(function()
        while Toggles.AutoEgg.Value do
            OpenEgg:FireServer('Cyborg Egg', true)
            task.wait(0.1)
        end
    end)

    LeftGroupBox:AddDivider()

    LeftGroupBox:AddLabel('Click TP'):AddKeyPicker('ClickTP', {
        Default = 'B',
        SyncToggleState = false, 
        Mode = 'Toggle',
    
        Text = 'Click Teleport',
        NoUI = false
    })

    Options.ClickTP:OnClick(function()
        local mouse = player:GetMouse()
        local hrp = player.Character:WaitForChild("HumanoidRootPart")

		if mouse.Target then
			hrp.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
		end
    end)

    local CyberGalaxy = LeftGroupBox:AddButton('Teleport to Cyber Galaxy', function()
        Teleport:FireServer("Cyber Galaxy")
    end)

    local Overworld = LeftGroupBox:AddButton('Teleport to Overworld', function()
        Teleport:FireServer("The Overworld")
    end)

    local MoveToEgg = LeftGroupBox:AddButton('Move to Cyborg Egg', function()
        humanoid:MoveTo(Vector3.new(8751.455078125, 5.546135425567627, 84.50495147705078))
        humanoid.MoveToFinished:Wait()
        humanoid:MoveTo(Vector3.new(8777.86328125, 13.609908103942871, 84.68412780761719))
    end)

    local DeleteUnicorn = LeftGroupBox:AddButton('Delete Glitch', function()
        for i,v in pairs(pets:GetChildren()) do
            if v:IsA("Frame") and v.Frame.ItemName.Text == "Glitch" then
                petNumber += 1
                sellTable[petNumber] = v.Name
            end
        end
        
        MultiDeletePets:FireServer(sellTable)
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
    SaveManager:SetFolder('RawrX3Nuzzles/Miners Heaven')
    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    ThemeManager:ApplyToTab(Tabs['UI Settings'])
    Library:Notify('Loaded Miners Heaven v'..ver..'! Meow meow ^-^', 5)

    -- Update checker from https://github.com/EdgeIY/infiniteyield
    task.spawn(function()
        Library:Notify('Running update check!', 2)
        while true do
            if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/uwuscutely/Scripts/main/Version'))() end) then
                if ver ~= MHVersion then
                    Library:Notify('Your current version of Miners Heaven is outdated!\n\nYour version: '..ver..'\nLatest version: '..MHVersion..'\n\nGrab the latest version by re-executing the script!', 25)
                end
            end
            task.wait(30)
        end
    end)

    if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/uwuscutely/Scripts/main/Version'))() end) then
        if ver == MHVersion then
            Library:Notify('You\'re running the latest verion of Miners Heaven!', 5)
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
end
