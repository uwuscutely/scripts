repeat wait(1) until game:IsLoaded()
print ("Ready to do all your dirty work :/")

local UwU = game:GetService("Players").LocalPlayer
local DeezNuts = UwU.Character or UwU.CharacterAdded:Wait()
local OwO = UwU.Name
local NeverGonnaGiveYouUp = game:GetService("ReplicatedStorage")
local TheSlaveStartedTheirShift = NeverGonnaGiveYouUp.Shared.Missions:WaitForChild("MissionStart")
local BossCommittedDie = NeverGonnaGiveYouUp.Shared.Missions:WaitForChild("MissionFinished")
local ReadyToGTFO = NeverGonnaGiveYouUp.Shared.Missions:WaitForChild("NotifyReadyToLeave")

repeat wait(1) until NeverGonnaGiveYouUp.Profiles[OwO]
print("Loaded this dumbass profile that apparently takes 69420 years to load...")

if NeverGonnaGiveYouUp.Profiles[OwO].Level.Value <= 31 then
	print("You passed the vibe check")
	
	if game.PlaceId == 4310464656 then
		DeezNuts:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(833, 74, 2283)
		print("Moved yo lazy ass to the corner")
	else
		print("Breh you're not even in the dungeon")
	end
	
    BossCommittedDie.OnClientEvent:Connect(function()
        print("The slave murdered the boss")
        ReadyToGTFO:FireServer()
        print("I pressed the ready button for you smh")
    end)
else
    print("You're over Level 32. Go start the dungeon and stop being lazy 🙄")
end
