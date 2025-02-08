local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "SecureHub"
GUI.ResetOnSpawn = false
GUI.Enabled = false

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.3, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true

local secretUnits = {
    "Golden Adult",
    "Radiant Monarch",
    "Poseidon (Sea Sovereign)",
    "Dragon Mage",
    "Shadow Master",
    "Abyssal Warden",
    "Elf Saint",
    "Celestial Guardian",
    "Voidwalker",
    "Prime Leader"
}

local function safeFireServer(unit)
    local args = {
        [1] = unit,
        [2] = "Secret",
        [3] = "AllVersions"
    }
    
    task.wait(math.random(0.5, 1.5))
    
    pcall(function()
        game:GetService("ReplicatedStorage").RemoteEvents.UnitPurchase:FireServer(unpack(args))
    end)
    
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        local newUnit = Instance.new("StringValue")
        newUnit.Name = unit
        newUnit.Parent = backpack
    end
end

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #secretUnits * 45)

for i, unit in pairs(secretUnits) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Text = unit
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*45)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    
    btn.MouseButton1Click:Connect(function()
        _G.SelectedUnit = unit
    end)
end

local ClaimButton = Instance.new("TextButton", MainFrame)
ClaimButton.Text = "Claim (Secure)"
ClaimButton.Size = UDim2.new(0.5, 0, 0.1, 0)
ClaimButton.Position = UDim2.new(0.25, 0, 0.88, 0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

ClaimButton.MouseButton1Click:Connect(function()
    if _G.SelectedUnit then
        safeFireServer(_G.SelectedUnit)
    end
end)

task.spawn(function()
    wait(10)
    GUI.Enabled = true
end)
