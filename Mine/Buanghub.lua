local function HackGame() 
local Player = game:GetService("Players").LocalPlayer
local Remote = game:GetService("ReplicatedStorage").RemoteEvent
    
hookfunction(game.IsLoaded, function() return true end)
    
    Remote:FireServer("AddUnit", "6★_Gojo")
    Remote:FireServer("AddCrystals", 99999)
end

HackGame()
