local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local GUI = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

GUI.Name = "6StarInjector"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

Button.Size = UDim2.new(0.85,0,0.18,0)
Button.Position = UDim2.new(0.075,0,0.75,0)
Button.BackgroundColor3 = Color3.new(0.2,0.7,0.2)
Button.TextColor3 = Color3.new(1,1,1)
Button.TextScaled = true
Button.Text = "INSTANT 6★ CHARACTERS"
Button.Parent = GUI

local Characters = {
    ["Gojo"] = 6,
    ["Luffy"] = 6,
    ["Zoro"] = 6,
    ["Naruto"] = 6,
    ["Sasuke"] = 6,
    ["Goku"] = 6,
    ["Tanjiro"] = 6,
    ["Levi"] = 6,
    ["Itachi"] = 6,
    ["Vegeta"] = 6
}

local function CreateTool(name)
    local tool = Instance.new("Tool")
    tool.Name = name
    
    local stars = Instance.new("IntValue")
    stars.Name = "Stars"
    stars.Value = 6
    stars.Parent = tool
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(2,2,2)
    handle.Parent = tool
    
    return tool
end

Button.MouseButton1Click:Connect(function()
    if not Player:FindFirstChild("Backpack") then
        Instance.new("Backpack").Parent = Player
    end
    
    for charName in pairs(Characters) do
        local tool = CreateTool(charName)
        tool.Parent = Player.Backpack
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "COMPLETED",
        Text = table.concat({"All",tostring(#Player.Backpack:GetChildren()),"6★ added"}," "),
        Duration = 3
    })
end)
