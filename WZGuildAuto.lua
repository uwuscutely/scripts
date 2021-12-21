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
            wait(5)
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
            wait(5)
            StartRaid:FireServer(missionID, difficulty + 1)
        end)
    else
        MissionFinished.OnClientEvent:Connect(function()
            wait(5)
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
            wait(5)
            StartRaid:FireServer(missionID, difficulty + 1)
        end)
    else
        MissionFinished.OnClientEvent:Connect(function()
            wait(5)
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
            wait(5)
            StartRaid:FireServer(missionID, difficulty + 1)
        end)
    else
        MissionFinished.OnClientEvent:Connect(function()
            wait(5)
            if missionID == 4 then
                StartRaid:FireServer(6, 1)
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
                wait(5)
                StartRaid:FireServer(missionID, 5)
            end)
        elseif difficulty == 2 and PlaceId == 6386112652 then
            MissionFinished.OnClientEvent:Connect(function()
                wait(5)
                StartRaid:FireServer(missionID, 5)
            end)
        elseif difficulty == 2 and PlaceId == 6510862058 then
            MissionFinished.OnClientEvent:Connect(function()
                wait(5)
                StartRaid:FireServer(missionID, 5)
            end)
        else
            MissionFinished.OnClientEvent:Connect(function()
                wait(5)
                StartRaid:FireServer(missionID, difficulty + 1)
            end)
        end
    else
        MissionFinished.OnClientEvent:Connect(function()
            wait(5)
            if missionID == 7 then
                StartRaid:FireServer(11, 1)
            elseif missionID == 16 then
                StartRaid:FireServer(18, 1)
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
    local TowerFinished = ReplicatedStorage.MissionScripts[missionID]:WaitForChild("TowerFinished")
    print("UwU", "OwO", missionID)
    TowerFinished.OnClientEvent:Connect(function()
        if missionID == 21 then
            wait(15)
            StartRaid:FireServer(24, 1)
        end
    end)
end

if PlaceId == 2978696440 or 4310476380 then -- Crabby, Scarecrow
    oneDifficulty()
elseif PlaceId == 4310464656 or 4310478830 or 3885726701 or 3994953548 or 4465988196 or 4465989351 or 4646475342 or 4646473427 then -- Dire Prob, Kingslayer, Ruin, Mama, Mountain Pass, Winter Cavern, Deserted, Scrap
    fourDifficulties()
elseif PlaceId == 3383444582 or 3165900886 or 4050468028 or 4465989998 or 4646475570 or 6386112652 or 6510862058 or 6847034886 then -- Gravetower, Volcano Dungeon, Volcano's Shadow, Winter Dungeon, Pyramid Dungeon, Konoh, Rough Waters, Underworld
    fiveDifficulties()
elseif PlaceId == 5703353651 then -- Prison Tower
    tower()
elseif PlaceId == 7071564842 then -- Mez Tower
    local missionID = ActiveMission.Value
    local TowerFinished = ReplicatedStorage.MissionScripts[missionID]:WaitForChild("TowerFinished")
    tower()
    TowerFinished.OnClientEvent:Connect(function()
        print("Wow the script worked.. Meow meow..")
    end)
end
