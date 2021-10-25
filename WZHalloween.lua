if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local character = Player.Character or Player.CharacterAdded:Wait()
local MissionFinished = ReplicatedStorage.Shared.Missions:WaitForChild("MissionFinished")
local LeaveChoice = ReplicatedStorage.Shared.Missions:WaitForChild("LeaveChoice")
local NotifyReadyToLeave = ReplicatedStorage.Shared.Missions:WaitForChild("NotifyReadyToLeave")

MissionFinished.OnClientEvent:Connect(function()
    LeaveChoice:FireServer("true")
    NotifyReadyToLeave:FireServer()
end)
