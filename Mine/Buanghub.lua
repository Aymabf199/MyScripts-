local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- GUI Setup
local GUI = Instance.new("ScreenGui")
GUI.Name = "UltimateHub_"..math.random(1000,9999)
GUI.Parent = game:GetService("CoreGui")
GUI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.35, 0, 0.65, 0)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local secretUnits = {
    "Golden Adult", "Radiant Monarch", "Poseidon (Sea Sovereign)",
    "Dragon Mage", "Shadow Master", "Abyssal Warden", "Elf Saint",
    "Celestial Guardian", "Voidwalker", "Prime Leader", "Crimson Tyrant",
    "Stormcaller", "Eternal Phoenix", "Timekeeper", "Lightbringer"
}

local function AdvancedSecureFire(unit)
    local Attempts = 0
    local MaxAttempts = 3
    repeat
        local args = {
            [1] = unit,
            [2] = "Secret",
            [3] = "PremiumPass",
            [4] = math.random(100000,999999)
        }
        task.wait(math.random(0.1, 0.3))
        mouse1click()
        task.wait(math.random(0.4, 0.7))
        local success, response = pcall(function()
            ReplicatedStorage.RemoteEvents.UnitPurchase:FireServer(unpack(args))
        end)
        if success and player.Backpack:FindFirstChild(unit) then
            return true
        end
        Attempts += 1
        task.wait(math.random(0.5, 1.5))
    until Attempts >= MaxAttempts
    local backupUnit = Instance.new("StringValue")
    backupUnit.Name = unit.."_Backup"
    backupUnit.Value = HttpService:JSONEncode({
        Timestamp = os.time(),
        UnitID = math.random(100000,999999)
    })
    backupUnit.Parent = player.Backpack
    return false
end

local selectedUnit = nil
for i, unit in pairs(secretUnits) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Text = unit
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*50)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        selectedUnit = unit
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 0)}):Play()
    end)
end

local ClaimButton = Instance.new("TextButton", MainFrame)
ClaimButton.Text = "🔥 CLAIM (ULTIMATE MODE) 🔥"
ClaimButton.Size = UDim2.new(0.7, 0, 0.1, 0)
ClaimButton.Position = UDim2.new(0.15, 0, 0.88, 0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
ClaimButton.TextColor3 = Color3.new(1, 1, 0.9)
ClaimButton.MouseButton1Click:Connect(function()
    if selectedUnit then
        ClaimButton.Text = "🛡️ Processing (Secure Mode)..."
        local result = AdvancedSecureFire(selectedUnit)
        if result then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "SUCCESS!",
                Text = selectedUnit.." added securely",
                Icon = "rbxassetid://11178404362",
                Duration = 5
            })
            GUI:Destroy()
        else
            ClaimButton.Text = "⚠️ Retrying (Military Grade)..."
            task.wait(1.5)
            AdvancedSecureFire(selectedUnit)
        end
    end
end)

task.spawn(function()
    while true do
        GUI.Name = "Hub_"..math.random(10000000,99999999)
        task.wait(5)
        for _ = 1, 20 do
            math.randomseed(tick())
        end
    end
end)
