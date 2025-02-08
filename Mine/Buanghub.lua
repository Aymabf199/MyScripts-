-- Universal Unit Injector (Client-Server Hybrid)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- Phantom Admin Interface
local GUI = Instance.new("ScreenGui")
local ActivateBtn = Instance.new("TextButton")

GUI.Name = "UnitMaster"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

ActivateBtn.Size = UDim2.new(0.25,0,0.4,0)
ActivateBtn.Position = UDim2.new(0.72,0,0.3,0)
ActivateBtn.Rotation = -90
ActivateBtn.BackgroundColor3 = Color3.new(0,0,0)
ActivateBtn.BorderColor3 = Color3.new(1,0,0)
ActivateBtn.Text = "🔥\nUNLOCK\nALL UNITS"
ActivateBtn.TextColor3 = Color3.new(1,0.5,0)
ActivateBtn.TextSize = 18
ActivateBtn.Parent = GUI

-- Unit Database (6★ Units Only)
local EliteUnits = {
    "Gojo", "Luffy", "Zoro", "Goku", 
    "Naruto", "Sasuke", "Madara", "Levi",
    "Eren", "Tanjiro", "Itachi", "Kakashi"
}

local function CreateUnitTool(unitName)
    local tool = Instance.new("Tool")
    tool.Name = unitName
    
    local stats = Instance.new("Folder")
    stats.Name = "UnitStats"
    
    local stars = Instance.new("IntValue")
    stars.Name = "Stars"
    stars.Value = 6
    
    local damage = Instance.new("IntValue")
    damage.Name = "Damage"
    damage.Value = math.random(5000,15000)
    
    stats.Parent = tool
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(2,2,2)
    handle.Parent = tool
    
    return tool
end

-- Shadow Injection System
ActivateBtn.MouseButton1Click:Connect(function()
    local backpack = Player:FindFirstChild("Backpack") or Instance.new("Backpack")
    backpack.Parent = Player
    
    for _, unit in pairs(EliteUnits) do
        local newUnit = CreateUnitTool(unit)
        newUnit.Parent = backpack
    end
    
    -- Fake Server Response
    ReplicatedStorage:SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM] All 6★ units unlocked (Admin Override)",
        Color = Color3.new(1,0,0),
        Font = Enum.Font.Fantasy
    })
    
    -- Auto-Camouflage
    delay(10, function()
        GUI:Destroy()
    end)
end)
