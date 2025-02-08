
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local GUI = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

GUI.Name = "UnitMaster"
GUI.Parent = Player:WaitForChild("PlayerGui")

Button.Size = UDim2.new(0.25,0,0.4,0)
Button.Position = UDim2.new(0.72,0,0.3,0)
Button.Rotation = -90
Button.BackgroundColor3 = Color3.new(0,0,0)
Button.BorderColor3 = Color3.new(1,0,0)
Button.Text = "🔥\nUNLOCK\nALL UNITS"
Button.TextColor3 = Color3.new(1,0.5,0)
Button.TextSize = 18
Button.Parent = GUI

local EliteUnits = {
    "Gojo", "Luffy", "Zoro", "Goku", 
    "Naruto", "Sasuke", "Madara", "Levi",
    "Eren", "Tanjiro", "Itachi", "Kakashi"
}

Button.MouseButton1Click:Connect(function()
    local backpack = Player:FindFirstChild("Backpack") or Instance.new("Backpack")
    backpack.Parent = Player
    
    for _, unit in pairs(EliteUnits) do
        local tool = Instance.new("Tool")
        tool.Name = unit
        
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(2,2,2)
        handle.Parent = tool
        
        local stars = Instance.new("IntValue")
        stars.Name = "Stars"
        stars.Value = 6
        stars.Parent = tool
        
        tool.Parent = backpack
    end
    
    game:GetService("ReplicatedStorage"):SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM] 6★ Units Unlocked",
        Color = Color3.new(1,0,0)
    })
end)
