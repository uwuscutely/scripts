local library = loadstring(game:HttpGet(("https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua")))()

local w = library:CreateWindow("Dragon Adventures") -- Creates the window

local b = w:CreateFolder("UwUs Cutely") -- Creates the folder(U will put here your buttons,etc)

b:Button(
"Easter Egg TP",
function()
   local noob = game.Players.LocalPlayer
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local TwT = ReplicatedStorage.EasterEventStorage:WaitForChild("GetEggRemote")

   for i, v in pairs(Workspace:GetDescendants()) do
      if v:IsA("MeshPart") and v.MeshId == "rbxassetid://6563267204" and v.Name ~= "Egg" then
         noob.Character.HumanoidRootPart.CFrame = v.CFrame
         wait()
         TwT:FireServer(v.Parent)
      end
   end
end
)

b:Button(
"Chaos Egg TP",
function()
   local noob = game.Players.LocalPlayer
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local OwO = ReplicatedStorage.EasterEventStorage:WaitForChild("GetCalendarEggRemote")

   for i, v in pairs(Workspace:GetDescendants()) do
      if v:IsA("MeshPart") and v.MeshId == "rbxassetid://6540320456" and v.Name ~= "Egg" then
         noob.Character.HumanoidRootPart.CFrame = v.CFrame
         wait()
         local UwU = OwO:InvokeServer(v.Parent)
         print(v.Parent, UwU)
      end
   end
end
)

b:Button(
"Carrot Cake Farm",
function()
   while wait() do
      for _,v in pairs(game:GetService("Workspace").HarvestZones.Fruit.Drops.Small:GetDescendants()) do
         if v:IsA("MeshPart")    then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.5)
            fireclickdetector(game:GetService("Workspace").HarvestZones.Fruit.Drops.Small.ClickDetector)
            wait(8)
         end
      end
   end
end
)

b:Toggle("Auto Collect",function(bool)
   shared.toggle = bool
   while true do
      for _,v in pairs(game:GetService("Workspace").HarvestZones.Fruit.Drops.Small:GetDescendants()) do
         if v:IsA("MeshPart")    then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.5)
            fireclickdetector(game:GetService("Workspace").HarvestZones.Fruit.Drops.Small.ClickDetector)
            wait(8)
			if shared.toggle == false then
			   break
			end
         end
      end
   end
end)

b:DestroyGui()
