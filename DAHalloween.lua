if not game:IsLoaded() then
    game.Loaded:Wait()
    print("Ready to do all your dirty work :/")
end

local UwU = game:GetService("Players").LocalPlayer
local NeverGonnaGiveYouUp = game:GetService("ReplicatedStorage")
local RawrX3Nuzzles = game:GetService("Workspace")
local DeezNuts = UwU.Character or UwU.CharacterAdded:Wait()
local StalkThoseEggs = RawrX3Nuzzles.Interactions.Nodes.Harvest.Eggs.ActiveNodes
local EatTheEgg = NeverGonnaGiveYouUp.Remotes.HarvestDropsRemote

StalkThoseEggs.ChildAdded:Connect(function()
	local SlapThatEgg = RawrX3Nuzzles.StalkThoseEggs.Halloween2021:WaitForChild("Egg")
	local ClickTheDumbEgg = RawrX3Nuzzles.StalkThoseEggs.Halloween2021:WaitForChild("StateRemote")
	local SmaccTheTarget = RawrX3Nuzzles.StalkThoseEggs.Halloween2021:WaitForChild("BoostRemote")
	local AmountOfSmaccs = 0
	
	wait(5)
	DeezNuts:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(SlapThatEgg.CFrame)
	wait(1)
	ClickTheDumbEgg:InvokeServer("true")
	
	repeat
		AmountOfSmaccs = AmountOfSmaccs + 1
		SmaccTheTarget:InvokeServer("true")
		wait(1)
	until AmountOfSmaccs == 8 
	
	EatTheEgg:FireServer("Halloween2021", 1)
end)
