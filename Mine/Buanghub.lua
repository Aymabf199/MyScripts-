local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local secretUnits = {
    ["Golden Adult"] = "UR_G0LD3N_SSS",
    ["Radiant Monarch"] = "SSR_R4D14NT",
    ["Poseidon"] = "LR_P0S31D0N",
    ["Voidwalker"] = "MYTHIC_V01D",
    ["Timekeeper"] = "DIV1NE_T1ME"
}

local GUI = Instance.new("ScreenGui", game.CoreGui)
GUI.Name = "AnimeDefendersHub_" .. math.random(1000, 9999)

local MainFrame = Instance.new("Frame", GUI)
MainFrame.Size = UDim2.new(0.35, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Active = true
MainFrame.Draggable = true

local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #secretUnits * 60)

local function SecureAddUnit(unitName, unitCode)
    local args = {
        unitCode,
        "Secret",
        HttpService:GenerateGUID(false),
        os.time()
    }
    
    task.wait(math.random(0.3, 1.2))
    
    local success = pcall(function()
        ReplicatedStorage.RemoteEvents.UnitPurchase:FireServer(unpack(args))
        
        if not player.Backpack:FindFirstChild(unitCode) then
            local unit = Instance.new("StringValue")
            unit.Name = unitCode
            unit.Value = unitName
            unit.Parent = player.Backpack
        end
    end)
    
    return success
end

local yPos = 5
for unitName, unitCode in pairs(secretUnits) do
    local btn = Instance.new("TextButton", ScrollingFrame)
    btn.Text = unitName
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        }):Play()
        
        SecureAddUnit(unitName, unitCode)
    end)
    
    yPos += 55
end

local ClaimAllBtn = Instance.new("TextButton", MainFrame)
ClaimAllBtn.Text = "Claim All Units"
ClaimAllBtn.Size = UDim2.new(0.8, 0, 0.08, 0)
ClaimAllBtn.Position = UDim2.new(0.1, 0, 0.9, 0)
ClaimAllBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
ClaimAllBtn.TextColor3 = Color3.new(1, 1, 1)

ClaimAllBtn.MouseButton1Click:Connect(function()
    for unitName, unitCode in pairs(secretUnits) do
        SecureAddUnit(unitName, unitCode)
        task.wait(0.5)
    end
    GUI:Destroy()
end)
