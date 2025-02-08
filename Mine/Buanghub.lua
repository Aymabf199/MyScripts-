local module = {_SECRET_RARITY = 0.0025}

local _ENV = getgenv()
local secureConfig = {
    SummonAnchor = "SummonZoneMarker",
    SecretUnits = {
        ["The Gamer"] = {id = 88721, evolution = "Demon Greatsword", rarity = 0.009},
        ["Chance Taker"] = {id = 66534, evolution = "Roulette Machine", rarity = 0.007},
        ["Poseidon (Sea Sovereign)"] = {id = 44328, ability = "30% Freeze: Slow"},
        ["Radiant Monarch"] = {id = 27159, bleed = "175% Damage/7 ticks"},
        ["Sage (Deity)"] = {id = 54891, spa = "High"},
        ["Shadow Master"] = {id = 62904, burn = "60% Damage/4 ticks"}
    },
    RemotePath = "GameNetwork.TransactionSystem"
}

local function validateEnvironment()
    local summonZone = game:GetService("Workspace"):FindFirstChild(secureConfig.SummonAnchor)
    if not summonZone then return false end
    local playerChar = game.Players.LocalPlayer.Character
    if not playerChar then return false end
    local rootPart = playerChar:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    local distance = (rootPart.Position - summonZone.Position).Magnitude
    return distance <= summonZone.Size.X * 1.25
end

function module.createSecretInterface()
    if not validateEnvironment() then 
        warn("[Security] Execution context invalid")
        return 
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "GhostSummonerUI"
    gui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.25, 0, 0.6, 0)
    mainFrame.Position = UDim2.new(0.75, 0, 0.2, 0)
    mainFrame.BackgroundTransparency = 0.9
    mainFrame.Parent = gui

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.95, 0, 0.95, 0)
    scroll.CanvasSize = UDim2.new(0, 0, #secureConfig.SecretUnits * 0.2, 0)
    scroll.Parent = mainFrame

    for unitName, unitData in pairs(secureConfig.SecretUnits) do
        local btn = Instance.new("TextButton")
        btn.Text = string.format("%s\nID: %d | Rarity: %.3f%%", unitName, unitData.id, unitData.rarity * 100)
        btn.Size = UDim2.new(0.98, 0, 0.18, 0)
        btn.MouseButton1Click:Connect(function()
            if validateEnvironment() then
                _ENV.activateSummonProtocol(unitData.id)
            else
                gui:Destroy()
            end
        end)
        btn.Parent = scroll
    end
end

function _ENV.activateSummonProtocol(unitId)
    local validationCounter = 0
    local maxAttempts = 5
    
    while validationCounter < maxAttempts do
        if not validateEnvironment() then break end
        
        local args = {
            [1] = "SecretCompanion",
            [2] = unitId,
            [3] = game:GetService("Players").LocalPlayer,
            [4] = os.time()
        }
        
        local success, response = pcall(function()
            return game:GetService("ReplicatedStorage"):WaitForChild(secureConfig.RemotePath):FireServer(unpack(args))
        end)
        
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "SECRET SUMMONED",
                Text = "Unit " .. unitId .. " acquired!",
                Icon = "rbxassetid://4458901886",
                Duration = 5
            })
            break
        else
            validationCounter = validationCounter + 1
            task.wait(math.random(1, 3))
        end
    end
end

if validateEnvironment() then
    module.createSecretInterface()
else
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        task.wait(3)
        if validateEnvironment() then
            module.createSecretInterface()
        end
    end)
end

return module
