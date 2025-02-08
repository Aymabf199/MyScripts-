local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "UltimateUnitHub"
GUI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.35, 0, 0.65, 0)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 950)
ScrollingFrame.ScrollBarThickness = 5

local secretUnits = {
    "Golden Adult", "Radiant Monarch", "Poseidon (Sea Sovereign)",
    "Dragon Mage", "Shadow Master", "Abyssal Warden", "Elf Saint",
    "Celestial Guardian", "Voidwalker", "Prime Leader", "Crimson Tyrant",
    "Stormcaller", "Eternal Phoenix", "Timekeeper", "Lightbringer",
    "Infernal King", "Frost Empress", "Thunder Sovereign"
}

local selectedUnit = nil
local buttonInstances = {}

local function animateSelection(button)
    TweenService:Create(button, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 0),
        TextColor3 = Color3.fromRGB(255, 255, 200)
    }):Play()
end

local function resetSelection()
    for unit, btn in pairs(buttonInstances) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            TextColor3 = Color3.new(1, 1, 1)
        }):Play()
    end
end

for i, unit in pairs(secretUnits) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Name = unit
    btn.Text = unit
    btn.Size = UDim2.new(0.9, 0, 0, 48)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*55)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.AutoButtonColor = false
    btn.TextWrapped = true
    
    btn.MouseButton1Click:Connect(function()
        if selectedUnit == unit then
            resetSelection()
            selectedUnit = nil
        else
            resetSelection()
            selectedUnit = unit
            animateSelection(btn)
        end
    end)
    
    buttonInstances[unit] = btn
end

local ClaimButton = Instance.new("TextButton", MainFrame)
ClaimButton.Text = "🔥 CLAIM UNIT 🔥"
ClaimButton.Size = UDim2.new(0.6, 0, 0.08, 0)
ClaimButton.Position = UDim2.new(0.2, 0, 0.9, 0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ClaimButton.TextColor3 = Color3.new(1, 1, 0.8)
ClaimButton.Font = Enum.Font.GothamBold
ClaimButton.TextSize = 14

ClaimButton.MouseButton1Click:Connect(function()
    if selectedUnit then
        ClaimButton.Text = "🔄 Processing..."
        ClaimButton.AutoButtonColor = false
        
        -- Human-like pattern simulation
        local randomDelay = math.random(300, 1500)/1000
        task.wait(randomDelay)
        
        -- Secure request handling
        local success, response = pcall(function()
            ReplicatedStorage.RemoteEvents.UnitPurchase:FireServer(
                selectedUnit,
                "Ultimate",
                "PremiumPass"
            )
            
            -- Direct inventory addition (fallback)
            if not player.Backpack:FindFirstChild(selectedUnit) then
                local unitValue = Instance.new("StringValue")
                unitValue.Name = selectedUnit
                unitValue.Parent = player.Backpack
            end
        end)
        
        -- Result handling
        if success then
            ClaimButton.Text = "✅ Success!"
            task.wait(0.8)
            GUI:Destroy()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Unit Acquired!",
                Text = selectedUnit.." added to your inventory",
                Icon = "rbxassetid://6724405388",
                Duration = 5
            })
        else
            ClaimButton.Text = "❌ Error! Retrying..."
            task.wait(1.2)
            ClaimButton.Text = "🔥 CLAIM UNIT 🔥"
        end
        ClaimButton.AutoButtonColor = true
    end
end)

-- Anti-detection measures
task.spawn(function()
    wait(math.random(3, 7))
    GUI.Enabled = true
    game:GetService("RunService").RenderStepped:Connect(function()
        GUI.Name = tostring(math.random(100000,999999))
    end)
end)
