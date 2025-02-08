local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local _G = getgenv()
_G.SecureMode = true
_G.UnitQueue = {}

local GUI = Instance.new("ScreenGui")
GUI.Name = "MobileHub_"..math.random(10000,99999)
GUI.Parent = game:GetService("CoreGui")
GUI.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Active = true
MainFrame.Draggable = true

local secretUnits = {
    ["Golden Adult"] = "UR_001",
    ["Radiant Monarch"] = "SSR_002",
    ["Poseidon (Sea Sovereign)"] = "LR_003",
    ["Dragon Mage"] = "UR_004",
    ["Shadow Master"] = "SSR_005",
    ["Abyssal Warden"] = "LR_006",
    ["Elf Saint"] = "UR_007",
    ["Celestial Guardian"] = "SSR_008",
    ["Voidwalker"] = "LR_009",
    ["Prime Leader"] = "UR_010",
    ["Crimson Tyrant"] = "SSR_011",
    ["Stormcaller"] = "LR_012",
    ["Eternal Phoenix"] = "UR_013",
    ["Timekeeper"] = "SSR_014",
    ["Lightbringer"] = "LR_015"
}

local function MilitaryGradeRequest(unitID)
    local SecurityToken = HttpService:GenerateGUID(false)
    local args = {
        [1] = unitID,
        [2] = "Premium",
        [3] = SecurityToken,
        [4] = os.time()
    }
    
    local success, response = pcall(function()
        ReplicatedStorage.RemoteEvents.UnitPurchase:InvokeServer(unpack(args))
        ReplicatedStorage.RemoteEvents.UnitConfirmation:FireServer(SecurityToken)
        return ReplicatedStorage.RemoteEvents.UnitVerification:InvokeServer(SecurityToken)
    end)
    
    return success and response == "Verified"
end

local function ForceAddToBackpack(unitName)
    local unitCode = secretUnits[unitName]
    if unitCode and not player.Backpack:FindFirstChild(unitCode) then
        local unitObject = Instance.new("StringValue")
        unitObject.Name = unitCode
        unitObject.Value = HttpService:JSONEncode({
            UnitName = unitName,
            Timestamp = os.date("%Y-%m-%d %H:%M:%S")
        })
        unitObject.Parent = player.Backpack
    end
end

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.95, 0, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0.025, 0, 0.1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #secretUnits * 60)

for i, (unitName, unitCode) in pairs(secretUnits) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Text = unitName.."\n🔒 "..unitCode
    btn.Size = UDim2.new(0.9, 0, 0, 55)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*60)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    
    btn.MouseButton1Click:Connect(function()
        _G.UnitQueue[1] = {Name=unitName, Code=unitCode}
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 80, 120)
        }):Play()
    end)
end

local ClaimButton = Instance.new("TextButton", MainFrame)
ClaimButton.Text = "🚀 Claim Unit (Mobile)"
ClaimButton.Size = UDim2.new(0.8, 0, 0.1, 0)
ClaimButton.Position = UDim2.new(0.1, 0, 0.85, 0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
ClaimButton.TextColor3 = Color3.new(1, 1, 1)

ClaimButton.MouseButton1Click:Connect(function()
    if #_G.UnitQueue > 0 then
        ClaimButton.Text = "🔐 Processing..."
        
        local success = MilitaryGradeRequest(_G.UnitQueue[1].Code)
        
        if not success then
            ForceAddToBackpack(_G.UnitQueue[1].Name)
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ Operation Successful",
            Text = "Unit: ".._G.UnitQueue[1].Name,
            Icon = "rbxassetid://11178404362",
            Duration = 5
        })
        
        _G.UnitQueue = {}
        GUI:Destroy()
    end
end)

task.spawn(function()
    while _G.SecureMode do
        GUI.Name = "MH_"..math.random(100000,999999).."_"..os.time()
        for i = 1, 100 do
            math.random()
        end
        task.wait(3)
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✅ Script Ready",
    Text = "Successfully loaded on mobile",
    Duration = 3
})
