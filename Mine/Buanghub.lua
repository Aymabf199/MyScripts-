local Player = game:GetService("Players").LocalPlayer
local GUI = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local B1 = Instance.new("TextButton")
local B2 = Instance.new("TextButton")
local B3 = Instance.new("TextButton")
local B4 = Instance.new("TextButton")
local TxtBox = Instance.new("TextBox")

GUI.Name = "ASTD_Hax"
GUI.Parent = Player:WaitForChild("PlayerGui")

Main.Size = UDim2.new(0.3,0,0.45,0)
Main.Position = UDim2.new(0.7,0,0.3,0)
Main.BackgroundColor3 = Color3.new(0,0,0)
Main.BackgroundTransparency = 0.4
Main.Parent = GUI

B1.Size = UDim2.new(0.9,0,0.2,0)
B1.Position = UDim2.new(0.05,0,0.05,0)
B1.Text = "6★ UNITS"
B1.TextColor3 = Color3.new(0,1,0)
B1.Parent = Main

B2.Size = UDim2.new(0.9,0,0.2,0)
B2.Position = UDim2.new(0.05,0,0.3,0)
B2.Text = "GET ORBS"
B2.TextColor3 = Color3.new(1,0.5,0)
B2.Parent = Main

TxtBox.Size = UDim2.new(0.6,0,0.15,0)
TxtBox.Position = UDim2.new(0.05,0,0.55,0)
TxtBox.PlaceholderText = "CRYSTALS"
TxtBox.Parent = Main

B3.Size = UDim2.new(0.3,0,0.15,0)
B3.Position = UDim2.new(0.67,0,0.55,0)
B3.Text = "CONFIRM"
B3.TextColor3 = Color3.new(1,1,0)
B3.Parent = Main

B4.Size = UDim2.new(0.9,0,0.2,0)
B4.Position = UDim2.new(0.05,0,0.75,0)
B4.Text = "CLEAR ALL"
B4.TextColor3 = Color3.new(1,0,0)
B4.Parent = Main

local function AddUnit(name)
    local tool = Instance.new("Tool")
    local handle = Instance.new("Part")
    local star = Instance.new("IntValue")
    
    tool.Name = name
    handle.Name = "Handle"
    handle.Transparency = 1
    star.Name = "Stars"
    star.Value = 6
    
    handle.Parent = tool
    star.Parent = tool
    return tool
end

local function AddOrb(orbType)
    local tool = Instance.new("Tool")
    local handle = Instance.new("Part")
    local tag = Instance.new("StringValue")
    
    tool.Name = orbType
    handle.Name = "Handle"
    tag.Name = "OrbType"
    tag.Value = orbType
    
    handle.Transparency = 1
    handle.Parent = tool
    tag.Parent = tool
    return tool
end

B1.MouseButton1Click:Connect(function()
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then
        backpack = Instance.new("Backpack")
        backpack.Parent = Player
    end
    
    for _,name in pairs({"Gojo","Luffy","Zoro","Naruto","Sasuke","Goku","Levi"}) do
        AddUnit(name).Parent = backpack
    end
end)

B2.MouseButton1Click:Connect(function()
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then
        backpack = Instance.new("Backpack")
        backpack.Parent = Player
    end
    
    for _,orb in pairs({"Fire","Water","Earth","Lightning","Time","Void"}) do
        AddOrb(orb).Parent = backpack
    end
end)

B3.MouseButton1Click:Connect(function()
    local amount = tonumber(TxtBox.Text)
    if amount then
        local ls = Player:FindFirstChild("leaderstats")
        if not ls then
            ls = Instance.new("Folder")
            ls.Name = "leaderstats"
            ls.Parent = Player
        end
        
        local crystals = ls:FindFirstChild("Crystals")
        if not crystals then
            crystals = Instance.new("IntValue")
            crystals.Name = "Crystals"
            crystals.Parent = ls
        end
        
        crystals.Value += amount
    end
end)

B4.MouseButton1Click:Connect(function()
    if Player:FindFirstChild("Backpack") then
        Player.Backpack:Clear()
    end
end)

getgenv().SecureMode = true
hookfunction(warn, function() end)
