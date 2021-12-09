if not game:IsLoaded() then
    game.Loaded:Wait()
    print("Ready to do all your dirty work :/")
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StartRaid = ReplicatedStorage.Shared.Teleport:WaitForChild("StartRaid")
local MissionFinished = ReplicatedStorage.Shared.Missions:WaitForChild("MissionFinished")
local GetDifficulty = ReplicatedStorage.Shared.Missions:WaitForChild("GetDifficulty")
local ActiveMission = ReplicatedStorage:WaitForChild("ActiveMission")
local PlaceId = game.PlaceId

local function oneDifficulty()
	local difficulty = GetDifficulty:InvokeServer()
	local missionID = ActiveMission.Value
	print("UwU", "OwO", missionID, difficulty)
	
	if difficulty < 4 then
		MissionFinished.OnClientEvent:Connect(function()
			StartRaid:FireServer(missionID + 1, 1)
		end)
	end
end

local function twoDifficulties()
	local difficulty = GetDifficulty:InvokeServer()
	local missionID = ActiveMission.Value
	print("UwU", "OwO", missionID, difficulty)
	
	if difficulty < 2 then
		MissionFinished.OnClientEvent:Connect(function()
			StartRaid:FireServer(missionID, difficulty + 1)
		end)
	else
		MissionFinished.OnClientEvent:Connect(function()
			StartRaid:FireServer(missionID + 1, 1)
		end)
	end
end

local function threeDifficulties()
	local difficulty = GetDifficulty:InvokeServer()
	local missionID = ActiveMission.Value
	print("UwU", "OwO", missionID, difficulty)
	
	if difficulty < 3 then
		MissionFinished.OnClientEvent:Connect(function()
			StartRaid:FireServer(missionID, difficulty + 1)
		end)
	else
		MissionFinished.OnClientEvent:Connect(function()
			StartRaid:FireServer(missionID + 1, 1)
		end)
	end
end

local function fourDifficulties()
	local difficulty = GetDifficulty:InvokeServer()
	local missionID = ActiveMission.Value
	print("UwU", "OwO", missionID, difficulty)
	
	if difficulty < 4 then
		MissionFinished.OnClientEvent:Connect(function()
			StartRaid:FireServer(missionID, difficulty + 1)
		end)
	else
		MissionFinished.OnClientEvent:Connect(function()
			if missionID == 4 then
				StartRaid:FireServer(6, 1)
			elseif missionID == 16 then
				StartRaid:FireServer(18, 1)
			elseif missionID == 20 then
				StartRaid:FireServer(21)
			else
				StartRaid:FireServer(missionID + 1, 1)
			end
		end)
	end
end

local function fiveDifficulties()
	local difficulty = GetDifficulty:InvokeServer()
	local missionID = ActiveMission.Value
	print("UwU", "OwO", missionID, difficulty)
	
	if difficulty < 5 then
		if difficulty == 2 and PlaceId == 6847034886 then
			MissionFinished.OnClientEvent:Connect(function()
				StartRaid:FireServer(missionID, 5)
			end)
		else
			MissionFinished.OnClientEvent:Connect(function()
				StartRaid:FireServer(missionID, difficulty + 1)
			end)
		end
	else
		MissionFinished.OnClientEvent:Connect(function()
			if missionID == 7 then
				StartRaid:FireServer(11, 1)
			elseif missionID == 26 then
				StartRaid:FireServer(27)
			else
				StartRaid:FireServer(missionID + 1, 1)
			end
		end)
	end
end

local function tower()
	local missionID = ActiveMission.Value
	print("UwU", "OwO", missionID)
	MissionFinished.OnClientEvent:Connect(function()
		if missionID == 21 then
			StartRaid:FireServer(26, 1)
		end
	end)
end
	

if PlaceId == 2978696440 then -- Crabby
	oneDifficulty()
elseif PlaceId == 4310476380 then -- Scarecrow
	oneDifficulty()
elseif PlaceId == 4310464656 then -- Dire Prob
	fourDifficulties()
elseif PlaceId == 4310478830 then -- Kingslayer
    fourDifficulties()
elseif PlaceId == 3383444582 then -- Gravetower
	fiveDifficulties()
elseif PlaceId == 3165900886 then -- Volcano Dungeon
	fiveDifficulties()
elseif PlaceId == 3885726701 then -- Ruin
	fourDifficulties()
elseif PlaceId == 3994953548 then -- Mama
	fourDifficulties()
elseif PlaceId == 4050468028 then -- Volcano's Shadow
	fiveDifficulties()
elseif PlaceId == 4465988196 then -- Mountain Pass
	fourDifficulties()
elseif PlaceId == 4465989351 then -- Winter Cavern
	fourDifficulties()
elseif PlaceId == 4465989998 then -- Winter Dungeon
	fourDifficulties()
elseif PlaceId == 4646475570 then -- Pyramid Dungeon
	fiveDifficulties()
elseif PlaceId == 4646475342 then -- Deserted
	fourDifficulties()
elseif PlaceId == 4646473427 then -- Scrap
	fourDifficulties()
elseif PlaceId == 5703353651 then -- Prison Tower
	tower()
elseif PlaceId == 6847034886 then -- Underworld
	fiveDifficulties()
elseif PlaceId == 7071564842 then -- Mez Tower
	tower()
	MissionFinished.OnClientEvent:Connect(function()
		print("Wow the script worked.. Meow meow..")
    end)
end
