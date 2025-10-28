-- Astd Ultimate Hub Loadstring Version
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Astd Ultimate Hub", "DarkTheme")

local AutoFarm = false
local AutoRestart = false
local AutoSkip = false
local AutoEvolve = false

-- Auto Farm
local function StartAutoFarm()
    AutoFarm = true
    while AutoFarm do
        task.wait(0.5)
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Attack"):FireServer()
        end)
    end
end

local function StopAutoFarm()
    AutoFarm = false
end

-- Auto Restart
local function StartAutoRestart()
    AutoRestart = true
    while AutoRestart do
        task.wait(60)
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RestartGame"):FireServer()
        end)
    end
end

-- Auto Skip
local function StartAutoSkip()
    AutoSkip = true
    while AutoSkip do
        task.wait(2)
        pcall(function()
            local Player = game:GetService("Players").LocalPlayer
            if Player:FindFirstChild("PlayerGui") then
                local Dialogue = Player.PlayerGui:FindFirstChild("Dialogue")
                if Dialogue and Dialogue:FindFirstChild("Skip") then
                    Dialogue.Skip:Fire()
                end
            end
        end)
    end
end

-- Get Rare Units
local function GetRareUnits()
    local rareUnits = {"Dark Matter", "Galaxy", "Infinity", "Omega", "Universe"}
    for _, unitName in pairs(rareUnits) do
        task.wait(0.3)
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SpawnUnit"):FireServer(unitName)
        end)
    end
end

-- Claim Daily Rewards
local function ClaimDailyRewards()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ClaimDailyReward"):FireServer()
    end)
end

-- Auto Evolve
local function StartAutoEvolve()
    AutoEvolve = true
    while AutoEvolve do
        task.wait(10)
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EvolveUnit"):FireServer()
        end)
    end
end

-- GUI
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Quick Actions")

MainSection:NewButton("Claim Daily Rewards", "Get all daily rewards", function()
    ClaimDailyRewards()
end)

MainSection:NewButton("Get All Rare Units", "Spawn legendary units", function()
    GetRareUnits()
end)

MainSection:NewButton("Open All Crates", "Open all available crates", function()
    pcall(function()
        for i = 1, 10 do
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("OpenCrate"):FireServer()
            task.wait(0.2)
        end
    end)
end)

local FarmTab = Window:NewTab("Auto Farm")
local FarmSection = FarmTab:NewSection("Farming Settings")

FarmSection:NewToggle("Auto Farm", "Automatically farm coins and XP", function(state)
    if state then
        StartAutoFarm()
    else
        StopAutoFarm()
    end
end)

FarmSection:NewToggle("Auto Restart", "Auto restart when finished", function(state)
    if state then
        StartAutoRestart()
    else
        AutoRestart = false
    end
end)

FarmSection:NewToggle("Auto Skip", "Skip all dialogues", function(state)
    if state then
        StartAutoSkip()
    else
        AutoSkip = false
    end
end)

FarmSection:NewToggle("Auto Evolve", "Auto evolve units", function(state)
    if state then
        StartAutoEvolve()
    else
        AutoEvolve = false
    end
end)

local UnitsTab = Window:NewTab("Units")
local UnitsSection = UnitsTab:NewSection("Spawn Units")

UnitsSection:NewButton("Dark Matter Unit", "Spawn Dark Matter", function()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SpawnUnit"):FireServer("Dark Matter")
    end)
end)

UnitsSection:NewButton("Galaxy Unit", "Spawn Galaxy", function()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SpawnUnit"):FireServer("Galaxy")
    end)
end)

UnitsSection:NewButton("Infinity Unit", "Spawn Infinity", function()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SpawnUnit"):FireServer("Infinity")
    end)
end)

print("Astd Hub Loaded Successfully!")
