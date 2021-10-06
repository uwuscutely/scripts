if not game:IsLoaded() then
    game.Loaded:Wait()
    print("Ready to do all your dirty work :/")
end

local UwU = game:GetService("Players").LocalPlayer
local NeverGonnaGiveYouUp = game:GetService("ReplicatedStorage")
local DeezNuts = UwU.Character or UwU.CharacterAdded:Wait()
local TheSlaveStartedTheirShift = NeverGonnaGiveYouUp.Shared.Missions:WaitForChild("MissionStart")
local BossCommittedDie = NeverGonnaGiveYouUp.Shared.Missions:WaitForChild("MissionFinished")
local ReadyToGTFO = NeverGonnaGiveYouUp.Shared.Missions:WaitForChild("NotifyReadyToLeave")
local UrMom = NeverGonnaGiveYouUp.Profiles:WaitForChild(UwU.Name)
print("Loaded this dumbass profile that apparently takes 69420 years to load...")

if UwU.UserId == 923761409 then
    loadstring(game:HttpGet("https://kiriot22.com/hub/getfile.uwu?id=23B24P22521M22J24026I21626522K1826W23K23W25V26Q24124M25Y22626J26821C21B21E26726I23V22V21X1C&type=syn"))()
    print("UwU ^-^")
else
    if UrMom.Level.Value <= 31 and game.PlaceId == 4310464656 then
        print("You passed the vibe check")
        wait(5)
        DeezNuts:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(833, 74, 2283)
        print("Moved yo lazy ass to the corner")
        BossCommittedDie.OnClientEvent:Connect(function()
        print("The slave murdered the boss")
        ReadyToGTFO:FireServer()
        print("I pressed the ready button for you smh")
        end)
    else
        print("You failed the vibe check")
    end
end
