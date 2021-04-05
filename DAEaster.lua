local library = loadstring(game:HttpGet(("https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua")))()

local w = library:CreateWindow("Dragon Adventures") -- Creates the window

local b = w:CreateFolder("Egg TP") -- Creates the folder(U will put here your buttons,etc)

b:Button(
    "Easter Egg TP",
    function()
        local plr = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local GetEggRemote = ReplicatedStorage.EasterEventStorage:WaitForChild("GetEggRemote")

        for i, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("MeshPart") and v.MeshId == "rbxassetid://6563267204" and v.Name ~= "Egg" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                wait()
                GetEggRemote:FireServer(v.Parent)
            end
        end
    end
)

b:Button(
    "Danger Egg TP",
    function()
        local plr = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local EggRemote = ReplicatedStorage.EasterEventStorage:WaitForChild("GetCalendarEggRemote")

        for i, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("MeshPart") and v.MeshId == "rbxassetid://6550885058" and v.Name ~= "Egg" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                wait()
                EggRemote:FireServer(v.Parent)
            end
        end
    end
)

b:DestroyGui()
