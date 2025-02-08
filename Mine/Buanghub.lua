local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local _G = getrenv()

_G.UnitDatabase = {
    ["Golden Adult"] = {Code = "URxG0LD3N_2024", Rarity = 7},
    ["Radiant Monarch"] = {Code = "SSRxR4D14NTv2", Rarity = 6},
    ["Poseidon"] = {Code = "LRxP0S31D0N_X", Rarity = 8},
    ["Dragon Mage"] = {Code = "DR4G0N_MKII", Rarity = 7},
    ["Shadow Master"] = {Code = "SH4D0W_ELITE", Rarity = 6},
    ["Celestial Guardian"] = {Code = "C3L3ST14Lv3", Rarity = 8},
    ["Voidwalker"] = {Code = "V01D_W4LK3R", Rarity = 9},
    ["Crimson Tyrant"] = {Code = "CR1MS0N_TYR4NT", Rarity = 7},
    ["Eternal Phoenix"] = {Code = "PH03N1X_ET3RN4L", Rarity = 9},
    ["Timekeeper"] = {Code = "T1M3K33P3R_Z", Rarity = 10}
}

local function InjectUnit(unitData)
    local success = pcall(function()
        ReplicatedStorage.RemoteEvents.UnitPurchase:FireServer(
            unitData.Code,
            "Secret",
            "PremiumPass"
        )
        
        if not player.Backpack:FindFirstChild(unitData.Code) then
            local unitObject = Instance.new("StringValue")
            unitObject.Name = unitData.Code
            unitObject.Value = HttpService:JSONEncode({
                UnitName = unitData.Name,
                Timestamp = os.date("%Y-%m-%d %H:%M:%S")
            })
            unitObject.Parent = player.Backpack
        end
    end)
    
    return success
end

local GUI = Instance.new("ScreenGui")
GUI.Name = "UltimateHub_"..math.random(10000,99999)
GUI.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.95, 0, 0.8, 0)
MainFrame.Position = UDim2.new(0.025, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.98, 0, 0.85, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #_G.UnitDatabase * 70)

local yPos = 5
for unitName, unitData in pairs(_G.UnitDatabase) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Text = unitName.."\n★"..unitData.Rarity
    btn.Size = UDim2.new(0.96, 0, 0, 65)
    btn.Position = UDim2.new(0.02, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    
    btn.MouseButton1Click:Connect(function()
        _G.SelectedUnit = unitData
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    end)
    
    yPos += 70
end

local ExecuteBtn = Instance.new("TextButton", MainFrame)
ExecuteBtn.Text = "🔥 CLAIM UNIT"
ExecuteBtn.Size = UDim2.new(0.9, 0, 0.08, 0)
ExecuteBtn.Position = UDim2.new(0.05, 0, 0.9, 0)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
ExecuteBtn.TextColor3 = Color3.new(1, 1, 1)

ExecuteBtn.MouseButton1Click:Connect(function()
    if _G.SelectedUnit then
        ExecuteBtn.Text = "⚡ PROCESSING..."
        local success = InjectUnit(_G.SelectedUnit)
        
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "✅ SUCCESS",
                Text = "Unit added: ".._G.SelectedUnit.Code,
                Duration = 5
            })
        else
            ExecuteBtn.Text = "🔄 RETRYING..."
            task.wait(1)
            InjectUnit(_G.SelectedUnit)
        end
        
        GUI:Destroy()
    end
end)

task.spawn(function()
    while task.wait(5) do
        GUI.Name = "Hub_"..HttpService:GenerateGUID(false)
    end
end)
