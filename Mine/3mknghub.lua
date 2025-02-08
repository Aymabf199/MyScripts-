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
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.95, 0, 0.75, 0)
MainFrame.Position = UDim2.new(0.025, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

local function GenerateFingerprint()
    return string.format("%X-%X-%X-%X",
        math.random(0x10000000, 0xFFFFFFFF),
        math.random(0x1000, 0xFFFF),
        math.random(0x1000, 0xFFFF),
        math.random(0x1000, 0xFFFF)
    )
end

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
    local SecurityToken = GenerateFingerprint()
    local requestData = {
        UnitId = unitID,
        PurchaseType = "Premium",
        SecurityToken = SecurityToken,
        Timestamp = os.time(),
        HardwareId = GenerateFingerprint()
    }
    
    local success, response = pcall(function()
        local purchaseResult = ReplicatedStorage.RemoteEvents.UnitPurchase:InvokeServer(
            requestData.UnitId,
            requestData.PurchaseType,
            requestData.SecurityToken,
            requestData.Timestamp
        )
        
        if purchaseResult == "Success" then
            ReplicatedStorage.RemoteEvents.UnitConfirmation:FireServer(SecurityToken)
            return ReplicatedStorage.RemoteEvents.UnitVerification:InvokeServer(SecurityToken)
        end
        return "Failed"
    end)
    
    return success and response == "Verified"
end

local function ForceAddToBackpack(unitName)
    local unitCode = secretUnits[unitName]
    if unitCode then
        local fakeTool = Instance.new("Tool")
        fakeTool.Name = unitCode
        fakeTool.RequiresHandle = false
        fakeTool.CanBeDropped = false
        
        local metadata = Instance.new("StringValue")
        metadata.Name = "UnitMetadata"
        metadata.Value = HttpService:JSONEncode({
            UnitName = unitName,
            Rarity = "Secret",
            Obtained = os.time()
        })
        metadata.Parent = fakeTool
        
        fakeTool.Parent = player.Backpack
    end
end

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #secretUnits * 70)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.Parent = MainFrame

for i, (unitName, unitCode) in pairs(secretUnits) do
    local btn = Instance.new("TextButton")
    btn.Text = string.format("%s\n%s", unitName, unitCode)
    btn.Size = UDim2.new(1, -20, 0, 60)
    btn.Position = UDim2.new(0, 10, 0, (i-1)*70)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = ScrollingFrame
    
    btn.MouseButton1Click:Connect(function()
        _G.UnitQueue[1] = {Name = unitName, Code = unitCode}
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 180)
        }):Play()
    end)
end

local ClaimButton = Instance.new("TextButton")
ClaimButton.Text = "🚀 Claim Unit (Mobile)"
ClaimButton.Size = UDim2.new(0.9, 0, 0.1, 0)
ClaimButton.Position = UDim2.new(0.05, 0, 0.85, 0)
ClaimButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
ClaimButton.TextColor3 = Color3.new(1, 1, 1)
ClaimButton.Font = Enum.Font.GothamBlack
ClaimButton.TextSize = 16
ClaimButton.Parent = MainFrame

ClaimButton.MouseButton1Click:Connect(function()
    if #_G.UnitQueue > 0 then
        ClaimButton.Text = "🔐 Processing..."
        ClaimButton.AutoButtonColor = false
        
        local selectedUnit = _G.UnitQueue[1]
        local success = MilitaryGradeRequest(selectedUnit.Code)
        
        if not success then
            ForceAddToBackpack(selectedUnit.Name)
        end
        
        task.wait(1.5)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ SUCCESS",
            Text = string.format("Acquired: %s", selectedUnit.Name),
            Icon = "rbxassetid://11178404362",
            Duration = 5
        })
        
        _G.UnitQueue = {}
        GUI:Destroy()
    end
end)

task.spawn(function()
    while _G.SecureMode do
        GUI.Name = "MH_"..GenerateFingerprint()
        if not GUI.Parent then break end
        task.wait(math.random(3, 7))
    end
end)

if RunService:IsMobile() then
    MainFrame.Size = UDim2.new(0.95, 0, 0.85, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #secretUnits * 80)
end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "📱 Mobile Hub Loaded",
    Text = "Select your desired unit!",
    Duration = 3
})
