-- Simple Mobile Unit Adder (Client-Side Only)
local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Mobile Interface
local UnitFrame = Instance.new("Frame")
UnitFrame.Size = UDim2.new(0.25,0,0.1,0)
UnitFrame.Position = UDim2.new(0.75,0,0.05,0)
UnitFrame.BackgroundTransparency = 0.8
UnitFrame.BackgroundColor3 = Color3.new(0,0,0)
UnitFrame.Parent = CoreGui

local AddButton = Instance.new("TextButton")
AddButton.Size = UDim2.new(1,0,1,0)
AddButton.Text = "➕ GET 6★"
AddButton.TextSize = 14
AddButton.TextColor3 = Color3.new(1,1,1)
AddButton.Parent = UnitFrame

-- Basic Unit Creation
local function CreateBasicUnit(name)
    local tool = Instance.new("Tool")
    tool.Name = name
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1,1,1)
    handle.Transparency = 0.5
    
    local starTag = Instance.new("IntValue")
    starTag.Name = "Stars"
    starTag.Value = 6
    
    handle.Parent = tool
    starTag.Parent = tool
    
    return tool
end

AddButton.MouseButton1Click:Connect(function()
    local backpack = Player:FindFirstChild("Backpack") 
    or Instance.new("Backpack", Player)
    
    local units = {
        "Gojo", "Luffy", "Zoro", "Goku",
        "Naruto", "Sasuke", "Levi", "Tanjiro"
    }
    
    for _, name in pairs(units) do
        CreateBasicUnit(name).Parent = backpack
    end
    
    -- Simple Notification
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
        "Units added: " .. #backpack:GetChildren()
    )
end)

-- Mobile Settings
UnitFrame.Active = true
UnitFrame.Draggable = true
UnitFrame.Selectable = true
