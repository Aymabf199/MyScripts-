local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local GUI = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

GUI.Name = "GhostAdmin"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

Button.Size = UDim2.new(0.3,0,0.5,0)
Button.Position = UDim2.new(0.8,0,0.25,0)
Button.Rotation = 90
Button.BackgroundTransparency = 0.7
Button.TextColor3 = Color3.new(1,0,0)
Button.Text = "👑\n6★\nUNLOCK"
Button.TextSize = 28
Button.Parent = GUI

local function GhostNotification()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
        Text = "[ADMIN] All 6★ characters injected to your inventory",
        Color = Color3.new(1,0.2,0.2),
        Font = Enum.Font.GothamBold
    })
end

Button.MouseButton1Click:Connect(function()
    if not Player:FindFirstChild("Backpack") then
        Instance.new("Backpack").Parent = Player
    end
    
    local CharList = {
        "Gojo","Luffy","Zoro","Naruto",
        "Sasuke","Goku","Levi","Itachi",
        "Tanjiro","Kakashi","Madara","Eren"
    }
    
    for _,name in pairs(CharList) do
        local tool = Instance.new("Tool")
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        tool.Name = name
        Instance.new("IntValue",tool).Name = "Stars"
        tool.Stars.Value = 6
        handle.Parent = tool
        tool.Parent = Player.Backpack
    end
    
    GhostNotification()
    wait(0.5)
    Button.Visible = false
end)
