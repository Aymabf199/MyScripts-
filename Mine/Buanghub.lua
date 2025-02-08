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
GUI.Name = "MH_"..math.random(100000,999999)
GUI.Parent = game:GetService("CoreGui")
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = RunService:IsMobile() and UDim2.new(0.95,0,0.85,0) or UDim2.new(0.4,0,0.6,0)
MainFrame.Position = UDim2.new(0.025,0,0.15,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

local function GenerateHWID()
    return string.format("%X-%X-%X-%X",
        math.random(0x10000000,0xFFFFFFFF),
        math.random(0x1000,0xFFFF),
        math.random(0x1000,0xFFFF),
        math.random(0x1000,0xFFFF)
    )
end

local secretUnits = {
    ["Golden Adult"] = "UR_001",
    ["Radiant Monarch"] = "SSR_002",
    ["Crimson Tyrant"] = "SSR_011",
    ["Draconic Warrior"] = "BP_101",
    ["Prime Leader"] = "UR_010",
    ["Garcia (Red One)"] = "EV_202"
}

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1,-10,0.8,0)
ScrollingFrame.Position = UDim2.new(0,5,0,40)
ScrollingFrame.CanvasSize = UDim2.new(0,0,0,#secretUnits*65)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.Parent = MainFrame

for i, (unitName, unitCode) in pairs(secretUnits) do
    local btn = Instance.new("TextButton")
    btn.Text = unitName.."\n"..unitCode
    btn.Size = UDim2.new(1,-10,0,60)
    btn.Position = UDim2.new(0,5,0,(i-1)*65)
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.TextColor3 = Color3.new(0.9,0.9,0.9)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = ScrollingFrame

    btn.MouseButton1Click:Connect(function()
        _G.UnitQueue[1] = {Name=unitName, Code=unitCode}
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0,100,150)}):Play()
    end)
end

local ClaimButton = Instance.new("TextButton")
ClaimButton.Text = "🚀 CLAIM UNIT"
ClaimButton.Size = UDim2.new(0.9,0,0.08,0)
ClaimButton.Position = UDim2.new(0.05,0,0.88,0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(0,120,200)
ClaimButton.TextColor3 = Color3.new(1,1,1)
ClaimButton.Font = Enum.Font.GothamBlack
ClaimButton.TextSize = 16
ClaimButton.Parent = MainFrame

ClaimButton.MouseButton1Click:Connect(function()
    if #_G.UnitQueue > 0 then
        ClaimButton.Text = "🔒 PROCESSING..."
        ClaimButton.AutoButtonColor = false
        
        local unitData = _G.UnitQueue[1]
        local args = {
            unitData.Code,
            "Premium",
            GenerateHWID(),
            os.time(),
            GenerateHWID()
        }

        local success = pcall(function()
            ReplicatedStorage.RemoteEvents.UnitPurchase:InvokeServer(unpack(args))
            ReplicatedStorage.RemoteEvents.UnitConfirmation:FireServer(args[3])
            return ReplicatedStorage.RemoteEvents.UnitVerification:InvokeServer(args[3]) == "Verified"
        end)

        if not success then
            local tool = Instance.new("Tool")
            tool.Name = unitData.Code
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.Parent = player.Backpack
        end

        task.wait(1.2)
        GUI:Destroy()
    end
end)

task.spawn(function()
    while _G.SecureMode do
        GUI.Name = "UI_"..GenerateHWID()
        if not GUI.Parent then break end
        task.wait(math.random(2,5))
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "✅ SCRIPT LOADED",
    Text = "Mobile Hub Activated",
    Duration = 3
})
