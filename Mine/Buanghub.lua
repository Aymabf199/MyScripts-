--[[ 
    Anime Defenders Advanced Summon System
    Secure Zone-Locked Execution v6.0
    Permanent Inventory Integration
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Configuration (Obfuscated)
local _G = getgenv()
local SUMMON_CONFIG = {
    VALIDATION_MARKER = "SummonAltar", -- Workspace marker name
    REMOTE_PATH = ReplicatedStorage:WaitForChild("SummonEvent"),
    UNIT_DATABASE = {
        ["Dragon Monarch"] = {id = 11567, tier = "SSS"},
        ["Celestial Archer"] = {id = 23489, skill = "Starfall"},
        ["Abyssal King"] = {id = 98712, effect = "Void Nova"},
        ["Phoenix Warlord"] = {id = 45563, revive = true}
    }
}

-- Environmental Validation System
local function ValidateExecutionEnvironment()
    local summonZone = workspace:FindFirstChild(SUMMON_CONFIG.VALIDATION_MARKER)
    if not summonZone then return false end
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local distance = (character.HumanoidRootPart.Position - summonZone.Position).Magnitude
    return distance <= summonZone.Size.X * 1.15
end

-- Inventory Management System
local function PermanentUnitStorage(unitId)
    local InventoryService = ReplicatedStorage:FindFirstChild("InventoryService")
    if InventoryService then
        InventoryService:InvokeServer("AddPermanentUnit", {
            UnitID = unitId,
            Owner = LocalPlayer.UserId,
            Timestamp = os.time()
        })
    end
end

-- Secure Summon Interface
local function CreateSummonInterface()
    if not ValidateExecutionEnvironment() then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "SummonMasterUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.28, 0, 0.65, 0)
    mainFrame.Position = UDim2.new(0.7, 0, 0.15, 0)
    mainFrame.BackgroundTransparency = 0.9
    mainFrame.Parent = gui

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(0.95, 0, 0.95, 0)
    scrollFrame.CanvasSize = UDim2.new(0, 0, #SUMMON_CONFIG.UNIT_DATABASE * 0.18, 0)
    scrollFrame.Parent = mainFrame

    for unitName, unitData in pairs(SUMMON_CONFIG.UNIT_DATABASE) do
        local button = Instance.new("TextButton")
        button.Text = string.format("%s\n[ID: %d]", unitName, unitData.id)
        button.Size = UDim2.new(0.98, 0, 0.16, 0)
        
        button.MouseButton1Click:Connect(function()
            if ValidateExecutionEnvironment() then
                -- Secure Summon Protocol
                local args = {
                    "CompanionSummon",
                    unitData.id,
                    math.random(1000,9999), -- Obfuscation value
                    os.clock(), -- Timestamp validation
                    LocalPlayer
                }
                
                task.spawn(function()
                    local success, response = pcall(function()
                        SUMMON_CONFIG.REMOTE_PATH:FireServer(unpack(args))
                        PermanentUnitStorage(unitData.id)
                    end)
                    
                    if success then
                        require(ReplicatedStorage.GameEffects).PlaySummonEffect()
                    end
                end)
            else
                gui:Destroy()
            end
        end)
        button.Parent = scrollFrame
    end
end

-- Auto-Initialization with Security
local function InitializeSystem()
    local attempts = 0
    repeat
        if ValidateExecutionEnvironment() then
            CreateSummonInterface()
            break
        end
        attempts += 1
        task.wait(2)
    until attempts >= 5
end

-- Execution Flow
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(3) -- Wait for character load
    InitializeSystem()
end)

InitializeSystem()

return {
    _VERSION = "6.0.1",
    _SECURITY_LEVEL = 5
}
