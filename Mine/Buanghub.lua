-- Mine/Buanghub.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
GUI.Name = "AnimeDefendersHub"
GUI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.35, 0, 0.65, 0)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 900)

local secretUnits = {
    "Golden Adult", "Radiant Monarch", "Poseidon (Sea Sovereign)",
    "Dragon Mage", "Shadow Master", "Abyssal Warden", "Elf Saint",
    "Celestial Guardian", "Voidwalker", "Prime Leader", "Crimson Tyrant",
    "Stormcaller", "Eternal Phoenix", "Timekeeper", "Lightbringer"
}

for i, unit in pairs(secretUnits) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Text = unit
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*50)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    
    btn.MouseButton1Click:Connect(function()
        _G.SelectedUnit = unit
    end)
end

local ClaimButton = Instance.new("TextButton", MainFrame)
ClaimButton.Text = "CLAIM UNIT"
ClaimButton.Size = UDim2.new(0.5, 0, 0.08, 0)
ClaimButton.Position = UDim2.new(0.25, 0, 0.9, 0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
ClaimButton.TextColor3 = Color3.new(1, 1, 1)

ClaimButton.MouseButton1Click:Connect(function()
    if _G.SelectedUnit then
        task.wait(math.random(0.3, 1.2))
        pcall(function()
            ReplicatedStorage.RemoteEvents.UnitPurchase:FireServer(
                _G.SelectedUnit,
                "Secret",
                "AnimeDefenders"
            )
        end)
    end
end)
